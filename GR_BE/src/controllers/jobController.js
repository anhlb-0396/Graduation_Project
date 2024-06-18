const catchAsync = require("../utils/catchAsync");
const AppError = require("../utils/appError");
const {
  Job,
  Company,
  JobImage,
  User,
  Tag,
  Industry,
  Province,
  Apply,
} = require("../models/databaseIndex");
const jobsData = require("../constant/jobsData");
const { addMonths } = require("date-fns");
const { validationResult } = require("express-validator");
const {
  s3,
  GetObjectCommand,
  DeleteObjectCommand,
  getSignedUrl,
} = require("../services/s3Bucket");

exports.getAllJobs = catchAsync(async (req, res, next) => {
  const jobs = await Job.findAll({
    where: req.query,
    include: [
      {
        model: Company,
      },
      {
        model: Tag,
      },
      {
        model: Industry,
      },
      {
        model: Province,
      },
    ],
    order: [["updatedAt", "DESC"]],
  });

  if (!jobs.length) return next(new AppError("No jobs found", 404));

  return res.status(200).json({
    status: "success",
    data: {
      count: jobs.length,
      jobs,
    },
  });
});

exports.getJobById = catchAsync(async (req, res, next) => {
  const errors = validationResult(req);

  if (!errors.isEmpty()) return next(new AppError(errors.array()[0].msg, 400));

  const job = await Job.findByPk(req.params.id, {
    include: [
      {
        model: Company,
        include: [
          {
            model: User,
          },
        ],
      },
      {
        model: JobImage,
      },
      {
        model: Tag,
      },
      {
        model: Industry,
      },
      {
        model: Province,
      },
      {
        model: Apply,
      },
    ],
  });

  if (!job) return next(new AppError("No job found", 404));

  const ownerCompany = await User.findOne({
    where: { company_id: job.Company.dataValues.id },
  });

  const ownerId = ownerCompany ? ownerCompany.id : null;

  const jobImages = job.JobImages.map(async (image) => {
    if (image.image.includes("http"))
      return { id: image.id, image: image.image };

    const command = new GetObjectCommand({
      Bucket: process.env.BUCKET_NAME,
      Key: image.image,
    });

    const handledUrl = await getSignedUrl(s3, command, {
      expiresIn: 3600 * 24 * 7,
    });
    return { id: image.id, image: handledUrl };
  });

  const handledImages = await Promise.all(jobImages);
  const jobData = job.toJSON();
  jobData.handledImages = handledImages;
  jobData.ownerId = ownerId;

  res.status(200).json({
    status: "success",
    data: {
      job: jobData,
    },
  });
});

exports.createJob = catchAsync(async (req, res, next) => {
  const data = { ...req.body };
  const s3Images = req.imagesName;
  const tags = data.tags ? data.tags.split(",").map((tag) => tag.trim()) : [];
  const industries = data.industries
    ? data.industries.split(",").map((industry) => industry.trim())
    : [];

  const job = await Job.create({
    ...data,
    gender: data.gender === "null" ? null : data.gender,
  });

  if (tags.length > 0) {
    const tagInstances = await Promise.all(
      tags.map((tag) => Tag.findOrCreate({ where: { tag } }))
    );
    const extractedTags = tagInstances.map(([tagInstance]) => tagInstance);

    await job.addTags(extractedTags, { through: "job_tags" });
  }

  if (industries.length > 0) {
    const industryInstances = await Promise.all(
      industries.map((industry) =>
        Industry.findOrCreate({ where: { industry } })
      )
    );
    const extractedIndustries = industryInstances.map(
      ([industryInstance]) => industryInstance
    );

    await job.addIndustries(extractedIndustries, { through: "job_industries" });
  }

  const jobImagesObj = s3Images.map((image) => {
    return {
      job_id: job.id,
      image,
    };
  });

  if (jobImagesObj.length === 0) {
    await JobImage.bulkCreate(jobImagesObj);
  }

  res.status(201).json({
    status: "success",
    message: "Job created successfully",
    data: { job },
  });
});

exports.updateJob = catchAsync(async (req, res, next) => {
  const jobId = req.params.id;
  const data = { ...req.body };
  const s3Images = req.imagesName;
  const tags = data.tags ? data.tags.split(",").map((tag) => tag.trim()) : [];
  const industries = data.industries
    ? data.industries.split(",").map((industry) => industry.trim())
    : [];

  const job = await Job.findByPk(jobId, { include: [JobImage, Tag, Industry] });

  if (!job) return next(new AppError("No job found", 404));

  // Delete all existing tags associated with the job
  await job.removeTags(job.Tags);
  await job.removeIndustries(job.Industries);

  // Find or create instances of the new tags
  if (tags.length > 0) {
    const tagInstances = await Promise.all(
      tags.map((tag) => Tag.findOrCreate({ where: { tag } }))
    );
    // Associate the job with the new tags
    await job.addTags(
      tagInstances.map(([tag]) => tag),
      { through: "job_tags" }
    );
  }

  // Find or create instances of the new industries

  if (industries.length > 0) {
    const industryInstances = await Promise.all(
      industries.map((industry) =>
        Industry.findOrCreate({ where: { industry } })
      )
    );
    // Associate the job with the new industries
    await job.addIndustries(
      industryInstances.map(([industry]) => industry),
      { through: "job_industries" }
    );
  }

  // Delete existing job images
  const jobImagesS3Delete = job.JobImages.map(async (image) => {
    if (!image.image.includes("http")) {
      const params = {
        Bucket: process.env.BUCKET_NAME,
        Key: image.image,
      };
      const command = new DeleteObjectCommand(params);
      await s3.send(command);
    }
  });

  await Promise.all(jobImagesS3Delete);
  await JobImage.destroy({ where: { job_id: jobId } });

  // Create job images
  const jobImagesObj = s3Images.map((image) => {
    return {
      job_id: jobId,
      image,
    };
  });

  await JobImage.bulkCreate(jobImagesObj);

  // Update job details
  await job.update({
    ...data,
    gender: data.gender === "null" ? null : data.gender,
  });

  res.status(200).json({
    status: "success",
    message: "Job updated successfully",
    data: { job },
  });
});

exports.deleteJob = catchAsync(async (req, res, next) => {
  const jobId = req.params.id;

  // Find the job including associated tags
  const job = await Job.findByPk(jobId, { include: [JobImage, Tag, Industry] });

  if (!job) return next(new AppError("No job found", 404));

  // Remove all associated tags
  await job.removeTags(job.Tags);
  await job.removeIndustries(job.Industries);

  // Delete job images
  const jobImagesS3Delete = job.JobImages.map(async (image) => {
    if (!image.image.includes("http")) {
      const params = {
        Bucket: process.env.BUCKET_NAME,
        Key: image.image,
      };
      const command = new DeleteObjectCommand(params);
      await s3.send(command);
    }
  });

  await Promise.all(jobImagesS3Delete);

  // Delete the job
  await job.destroy();

  res.status(204).json({
    status: "success",
    message: "Job deleted successfully",
    data: null,
  });
});

exports.importJobsToDB = catchAsync(async (req, res, next) => {
  return;
  console.log("importing jobs to db...");
  const newJobs = jobsData.map((job) => {
    return {
      ...job,
      min_salary: parseInt(job.min_salary),
      max_salary: parseInt(job.min_salary) + parseInt(job.min_salary) * 0.5,
      expired_date: addMonths(new Date(), 1),
    };
  });

  console.log(newJobs);

  const jobs = await Job.bulkCreate(newJobs);

  res.status(201).json({
    status: "success",
    data: {
      jobs,
    },
  });
});

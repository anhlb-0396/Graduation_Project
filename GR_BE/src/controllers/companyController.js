const catchAsync = require("../utils/catchAsync");
const AppError = require("../utils/appError");
const {
  Company,
  Reaction,
  User,
  Apply,
  Op,
  Job,
  Tag,
  Province,
  Industry,
  Resume,
} = require("../models/databaseIndex");
const companiesData = require("../constant/companies");
const { s3, GetObjectCommand, getSignedUrl } = require("../services/s3Bucket");
const resolveS3Urls = require("../utils/s3AWS");

exports.getAllCompanies = catchAsync(async (req, res, next) => {
  const companies = await Company.findAll({
    order: [["average_rating", "DESC"]],
  });

  if (!companies.length) return next(new AppError("No companies found", 404));

  return res.status(200).json({
    status: "success",
    data: {
      companies,
    },
  });
});

exports.createCompany = catchAsync(async (req, res, next) => {
  const {
    name,
    location,
    country,
    introduction,
    employees,
    website,
    contact_mail,
    province_id,
    logoUrl,
    coverImageUrl,
    agent_id,
  } = req.body;

  // Your logic to create a company, for example:
  const newCompany = await Company.create({
    name,
    location,
    country,
    introduction,
    employees,
    website,
    contact_mail,
    province_id,
    logo: logoUrl,
    cover_image: coverImageUrl,
  });

  await resolveS3Urls(newCompany, ["logo", "cover_image"]);

  const agent = await User.findByPk(agent_id);

  if (agent) {
    agent.company_id = newCompany.id;
    await agent.save();
  }

  res.status(201).json({
    status: "success",
    data: {
      company: newCompany,
    },
  });
});

exports.getCompanyById = catchAsync(async (req, res, next) => {
  const companyId = req.params.id;
  if (!companyId) return next(new AppError("Company ID is required", 400));

  const company = await Company.findByPk(companyId, {
    include: [
      {
        model: Reaction,
      },
    ],
  });

  if (!company) return next(new AppError("Company not found", 404));

  // Resolve S3 URLs for logo and cover_image fields
  const resolvedCompany = await resolveS3Urls(company, ["logo", "cover_image"]);

  return res.status(200).json({
    status: "success",
    data: {
      company: resolvedCompany,
    },
  });
});

exports.getCompanyComments = catchAsync(async (req, res, next) => {
  const companyId = req.params.id;
  if (!companyId) return next(new AppError("Company ID is required", 400));

  const comments = await Reaction.findAll({
    where: { company_id: companyId },
    order: [["updatedAt", "DESC"]],
    include: [
      {
        model: User,
        attributes: ["id", "name", "gmail", "avatar"],
      },
    ],
  });

  if (!comments.length) return next(new AppError("No comments found", 404));

  return res.status(200).json({
    status: "success",
    data: {
      comments,
    },
  });
});

exports.createCompanyComment = catchAsync(async (req, res, next) => {
  const data = { ...req.body };
  console.log(data);

  if (!data.company_id)
    return next(new AppError("Company ID is required", 400));

  if (!data.user_id) return next(new AppError("User ID is required", 400));

  const company = await Company.findByPk(data.company_id);
  if (!company) return next(new AppError("Company not found", 404));

  const reactionData = {
    user_id: data.user_id,
    company_id: data.company_id,
    comment: data.comment,
    salary_rating: data.salary_rating,
    working_space_rating: data.working_space_rating,
    colleague_relationship_rating: data.colleague_relationship_rating,
  };

  const newReaction = await Reaction.create(reactionData);

  res.status(201).json({
    status: "success",
    data: newReaction,
  });
});

exports.importCompaniesToDB = catchAsync(async (req, res, next) => {
  return;
  const dbCompanies = await Company.bulkCreate(companiesData);
  res.status(201).json({
    status: "success",
    data: {
      companies: dbCompanies,
    },
  });
});

exports.getCompanyApplies = catchAsync(async (req, res, next) => {
  const companyId = req.params.id;
  if (!companyId) return next(new AppError("Company ID is required", 400));

  const company = await Company.findByPk(companyId);
  if (!company) return next(new AppError("Company not found", 404));

  const jobsOfCompany = await company.getJobs({
    attributes: ["id"],
    raw: true,
  });

  const jobIds = jobsOfCompany.map((job) => job.id);

  const applies = await Apply.findAll({
    where: { job_id: { [Op.in]: jobIds } },
    include: [
      {
        model: User,
        attributes: ["id", "name", "gmail", "avatar"],
      },
      {
        model: Job,
        attributes: ["id", "title"],
        include: [
          {
            model: Company,
            attributes: ["id", "name"],
          },
        ],
      },
      {
        model: Resume,
      },
    ],
    order: [["updatedAt", "DESC"]],
  });

  const appliesPromises = applies.map(async (apply) => {
    if (apply.Resume && apply.Resume.is_uploaded && apply.Resume.resume_url) {
      const command = new GetObjectCommand({
        Bucket: process.env.BUCKET_NAME,
        Key: apply.Resume.resume_url,
      });

      const handledUrl = await getSignedUrl(s3, command, {
        expiresIn: 3600 * 24,
      });

      apply.Resume.resume_url = handledUrl;
    }

    return apply;
  });

  const parsedApplies = await Promise.all(appliesPromises);

  return res.status(200).json({
    status: "success",
    data: {
      applies: parsedApplies,
    },
  });
});

exports.getCompanyJobs = catchAsync(async (req, res, next) => {
  const companyId = req.params.id;
  if (!companyId) return next(new AppError("Company ID is required", 400));

  const company = await Company.findByPk(companyId);
  if (!company) return next(new AppError("Company not found", 404));

  const jobs = await company.getJobs({
    include: [
      {
        model: Company,
      },
      {
        model: Tag,
      },
      {
        model: Province,
      },
      {
        model: Industry,
      },
    ],
    order: [["updatedAt", "DESC"]],
  });

  return res.status(200).json({
    status: "success",
    data: {
      jobs,
    },
  });
});

exports.getCompanyStatisticsByIndustry = catchAsync(async (req, res, next) => {
  const companyId = req.params.id;
  if (!companyId) return next(new AppError("Company ID is required", 400));

  const company = await Company.findByPk(companyId, {
    include: [
      {
        model: Job,
        include: [Apply, Industry],
      },
    ],
  });
  if (!company) return next(new AppError("Company not found", 404));

  const companyIndustriesId = Array.from(
    new Set(
      company.Jobs.flatMap((job) =>
        job.Industries.map((industry) => industry.id)
      )
    )
  );

  const industries = await Industry.findAll();

  const statistics = companyIndustriesId.map((industryId) => {
    const jobsInIndustry = company.Jobs.filter((job) =>
      job.Industries.some((industry) => industry.id === industryId)
    );

    const totalJobs = jobsInIndustry.length;
    const totalAppliedUsers = jobsInIndustry.reduce((acc, job) => {
      return acc + (job.Applies ? job.Applies.length : 0);
    }, 0);

    const industryName = industries.find(
      (industry) => industry.id === industryId
    ).industry;

    return {
      industry: industryName,
      totalJobs,
      totalAppliedUsers,
    };
  });

  return res.status(200).json({
    status: "success",
    data: {
      statisticsByIndustries: statistics,
    },
  });
});

exports.getApplyStatisticsByApply = catchAsync(async (req, res, next) => {
  const companyId = req.params.id;
  if (!companyId) return next(new AppError("Company ID is required", 400));

  // Fetch the company including its jobs and applies
  const company = await Company.findByPk(companyId, {
    include: [
      {
        model: Job,
        include: Apply,
      },
    ],
  });
  if (!company) return next(new AppError("Company not found", 404));

  // Initialize an object to store apply counts by type
  const applyCountsByType = {
    pending: 0,
    "accepted-cv-round": 0,
    "accepted-interview-round": 0,
    rejected: 0,
  };

  // Iterate over each job in the company
  company.Jobs.forEach((job) => {
    // Iterate over each apply for the current job
    job.Applies.forEach((apply) => {
      // Increment the count of applies for the corresponding type
      applyCountsByType[apply.status]++;
    });
  });

  const statisticsArray = Object.entries(applyCountsByType).map(
    ([status, value]) => ({
      status,
      value,
    })
  );

  // Return the apply statistics by type
  return res.status(200).json({
    status: "success",
    data: {
      statisticsByApply: statisticsArray,
    },
  });
});

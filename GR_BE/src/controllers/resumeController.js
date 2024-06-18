const catchAsync = require("../utils/catchAsync");
const AppError = require("../utils/appError");
const { Resume } = require("../models/databaseIndex");
const {
  s3,
  GetObjectCommand,
  DeleteObjectCommand,
  getSignedUrl,
} = require("../services/s3Bucket");

exports.getAllResumes = catchAsync(async (req, res, next) => {
  const resumes = await Resume.findAll();

  if (!resumes.length) return next(new AppError("No resumes found", 404));

  const resumesPromises = resumes.map(async (resume) => {
    if (resume.is_uploaded && resume.resume_url) {
      const command = new GetObjectCommand({
        Bucket: process.env.BUCKET_NAME,
        Key: resume.resume_url,
      });

      const handledUrl = await getSignedUrl(s3, command, {
        expiresIn: 3600 * 24,
      });

      return {
        ...resume.dataValues,
        resume_url: handledUrl,
      };
    }

    return resume;
  });

  const parsedResumes = await Promise.all(resumesPromises);

  return res.status(200).json({
    status: "success",
    data: {
      resumes: parsedResumes,
    },
  });
});

exports.getResumeById = catchAsync(async (req, res, next) => {
  const resume = await Resume.findByPk(req.params.id);

  if (!resume) return next(new AppError("No resume found", 404));

  res.status(200).json({
    status: "success",
    data: {
      resume,
    },
  });
});

exports.createResume = catchAsync(async (req, res, next) => {
  const data = req.body;

  const newResume = await Resume.create({
    user_id: data.user_id,
    data: JSON.stringify(data.resume),
    name: data.resume_name,
  });

  console.log(JSON.parse(newResume.data));

  res.status(201).json({
    status: "success",
    data: {
      resume: newResume,
    },
  });
});

exports.uploadResume = catchAsync(async (req, res, next) => {
  const newResume = await Resume.create({
    user_id: req.body.userId,
    name: req.body.name,
    resume_url: req.resumeName,
    is_uploaded: true,
  });

  res.status(200).json({
    status: "success",
    data: {
      resume: newResume,
    },
  });
});

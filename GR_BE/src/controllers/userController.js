const catchAsync = require("../utils/catchAsync");
const AppError = require("../utils/appError");
const {
  User,
  Bookmark,
  Apply,
  ExpectJob,
  Op,
  Sequelize,
  Job,
  Company,
  Resume,
  Industry,
  Province,
  Tag,
  JobImage,
} = require("../models/databaseIndex");
const {
  s3,
  GetObjectCommand,
  DeleteObjectCommand,
  getSignedUrl,
} = require("../services/s3Bucket");

exports.getAllUsers = catchAsync(async (req, res, next) => {
  const users = await User.findAll();

  if (!users.length) return next(new AppError("No users found", 404));

  return res.status(200).json({
    status: "success",
    data: {
      users,
    },
  });
});

exports.updateUser = catchAsync(async (req, res, next) => {
  const { id } = req.params;
  const data = { ...req.body };
  const user = await User.findByPk(id);

  if (!user) return next(new AppError("User not found", 404));

  if (user.avatar) {
    const deleteCommand = new DeleteObjectCommand({
      Bucket: process.env.BUCKET_NAME,
      Key: user.avatar,
    });
    await s3.send(deleteCommand);
  }

  user.avatar = req.avatarName;
  user.date_of_birth = new Date(data.date_of_birth);
  user.name = data.name;

  await user.save();

  return res.status(200).json({
    status: "success",
    data: {
      user,
    },
  });
});

exports.getAllUsersByIds = catchAsync(async (req, res, next) => {
  const { userIds } = req.body;

  const users = await User.findAll({
    where: {
      id: {
        [Op.in]: userIds,
      },
    },
  });

  return res.status(200).json({
    status: "success",
    data: {
      users,
    },
  });
});

exports.getUserById = catchAsync(async (req, res, next) => {
  const { id } = req.params;

  const user = await User.findByPk(id);

  if (!user) return next(new AppError("User not found", 404));

  return res.status(200).json({
    status: "success",
    data: {
      user,
    },
  });
});

exports.getUserBookmarks = catchAsync(async (req, res, next) => {
  const { id } = req.params;

  const user = await User.findByPk(id, {
    include: {
      model: Bookmark,
      include: {
        model: Job,
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
      },
    },
  });

  if (!user) return next(new AppError("User not found", 404));

  return res.status(200).json({
    status: "success",
    data: {
      bookmarks: user.Bookmarks,
    },
  });
});

exports.createUserBookmark = catchAsync(async (req, res, next) => {
  const { id } = req.params;
  const bookmarkObject = { ...req.body };

  const user = await User.findByPk(id);

  if (!user) return next(new AppError("User not found", 404));

  await user.createBookmark({
    job_id: bookmarkObject.job_id,
  });

  return res.status(201).json({
    status: "success",
    data: {
      user,
    },
  });
});

exports.getUserApplies = catchAsync(async (req, res, next) => {
  const { id } = req.params;

  const user = await User.findByPk(id, {
    include: [
      {
        model: Apply,
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
      },
    ],
  });

  if (!user) return next(new AppError("User not found", 404));

  // const appliesPromises = user.Applies.map(async (apply) => {
  //   if (apply.Resume && apply.Resume.is_uploaded && apply.Resume.resume_url) {
  //     const command = new GetObjectCommand({
  //       Bucket: process.env.BUCKET_NAME,
  //       Key: apply.Resume.resume_url,
  //     });

  //     const handledUrl = await getSignedUrl(s3, command, {
  //       expiresIn: 3600 * 24,
  //     });

  //     apply.Resume.resume_url = handledUrl;
  //   }

  //   return apply;
  // });

  // Resolve s3 url foreach Resume of each user's apply

  const appliesPromises = user.Applies.map(async (apply) => {
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
  const resolvedApplies = await Promise.all(appliesPromises);

  return res.status(200).json({
    status: "success",
    data: {
      applies: resolvedApplies,
    },
  });
});

exports.createUserApply = catchAsync(async (req, res, next) => {
  const { id } = req.params;
  const applyObject = { ...req.body };

  const user = await User.findByPk(id);

  if (!user) return next(new AppError("User not found", 404));

  await user.createApply({
    job_id: applyObject.job_id,
    resume_id: applyObject.resume_id,
  });

  return res.status(201).json({
    status: "success",
    data: {
      user,
    },
  });
});

exports.getUserResumes = catchAsync(async (req, res, next) => {
  const { id } = req.params;

  const resumes = await Resume.findAll({
    where: {
      user_id: id,
    },
  });

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

async function searchExpectationJobs(expectJobs) {
  try {
    const {
      min_salary,
      industries,
      working_experience,
      working_method,
      working_type,
      province_id,
      skills,
    } = expectJobs;

    // Correct the logic for likeConditions creation
    const likeConditions =
      skills !== ""
        ? skills.split(", ").map((skill) => ({
            [Op.or]: [
              { title: { [Op.like]: `%${skill}%` } },
              { description: { [Op.like]: `%${skill}%` } },
              { "$Tags.tag$": { [Op.like]: `%${skill}%` } },
            ],
          }))
        : [];

    console.log("LIKE CONDITIONS: ", likeConditions);

    // Define the specific conditions
    let specificConditions = {
      min_salary: { [Op.gte]: min_salary },
      working_experience: { [Op.lte]: working_experience },
      working_method,
      working_type,
      province_id,
      "$Industries.id$": { [Op.in]: industries.split(",").map(Number) },
    };

    // Remove conditions if they are not provided
    if (!working_type) delete specificConditions.working_type;
    if (!working_method) delete specificConditions.working_method;
    if (!province_id) delete specificConditions.province_id;

    // Combine specificConditions with likeConditions using Op.or, if likeConditions is not empty
    if (likeConditions.length > 0) {
      specificConditions = {
        [Op.and]: [specificConditions, { [Op.or]: likeConditions }],
      };
    }

    // Query the Job model with the combined conditions
    const results = await Job.findAll({
      where: specificConditions,
      include: [
        { model: Company },
        { model: JobImage },
        { model: Tag },
        { model: Industry },
        { model: Province },
      ],
    });

    return results;
  } catch (error) {
    console.error("Error searching jobs by skills:", error);
    throw error;
  }
}

// async function searchExpectationJobs(expectJobs) {
//   try {
//     const {
//       min_salary,
//       industries,
//       working_experience,
//       working_method,
//       working_type,
//       province_id,
//       skills,
//     } = expectJobs;

//     // Create the likeConditions array based on jobSkills
//     const likeConditions =
//       skills === ""
//         ? skills.split(", ").map((skill) => ({
//             [Op.or]: [
//               { title: { [Op.like]: `%${skill}%` } },
//               { description: { [Op.like]: `%${skill}%` } },
//               { "$Tags.tag$": { [Op.like]: `%${skill}%` } },
//             ],
//           }))
//         : null;

//     console.log("LIKE CONDITIONS: ", likeConditions);

//     // Define the specific conditions
//     const specificConditions = {
//       min_salary: { [Op.gte]: min_salary },
//       working_experience: { [Op.lte]: working_experience },
//       working_method,
//       working_type,
//       province_id,
//       "$Industries.id$": { [Op.in]: industries.split(",").map(Number) },
//     };

//     if (!working_type) delete specificConditions.working_type;
//     if (!working_method) delete specificConditions.working_method;
//     if (!province_id) delete specificConditions.province_id;
//     if (!likeConditions) delete specificConditions.likeConditions;

//     // Combine specific conditions with likeConditions using Op.or
//     // const combinedConditions = {
//     //   [Op.or]: [specificConditions, likeConditions],
//     // };

//     // Query the Job model with combined conditions and includes
//     const results = await Job.findAll({
//       where: specificConditions,
//       include: [
//         {
//           model: Company,
//         },
//         {
//           model: JobImage,
//         },
//         {
//           model: Tag,
//         },
//         {
//           model: Industry,
//         },
//         {
//           model: Province,
//         },
//       ],
//     });

//     return results;
//   } catch (error) {
//     console.error("Error searching jobs by skills:", error);
//     throw error;
//   }
// }

exports.getAllUsersExpectJobs = catchAsync(async (req, res, next) => {
  const userId = req.params.id;
  if (!userId) return next(new AppError("User ID is required", 400));

  const expectJobs = await ExpectJob.findOne({
    where: { user_id: userId },
  });

  if (!expectJobs) return next(new AppError("No expect jobs found", 404));

  const results = await searchExpectationJobs(expectJobs);

  return res.status(200).json({
    status: "success",
    data: {
      count: results.length,
      expectJobs: results,
      requirement: expectJobs,
    },
  });
});

exports.updateExpectJobs = catchAsync(async (req, res, next) => {
  const userId = req.params.id;
  if (!userId) return next(new AppError("User ID is required", 400));

  const expectJobs = await ExpectJob.findOne({
    where: { user_id: userId },
  });

  if (!expectJobs) return next(new AppError("No expect jobs found", 404));

  const data = { ...req.body };

  expectJobs.min_salary = data.min_salary;
  expectJobs.industries = data.industries;
  expectJobs.working_experience = data.working_experience;
  expectJobs.working_method = data.working_method;
  expectJobs.working_type = data.working_type;
  expectJobs.province_id = data.province_id;
  expectJobs.skills = data.skills;

  await expectJobs.save();

  return res.status(200).json({
    status: "success",
    data: {
      expectJobs,
    },
  });
});

exports.getUserStatistics = catchAsync(async (req, res, next) => {
  const { id } = req.params;
  const user = await User.findByPk(id);
  if (!user) return next(new AppError("User not found", 404));

  const appliedJobsCount = await Apply.count({
    where: {
      user_id: id,
    },
  });

  const bookmarkedJobsCount = await Bookmark.count({
    where: {
      user_id: id,
    },
  });

  // const commentsCount = await user.countComments();

  const appliedJobs = await Apply.findAll({
    where: {
      user_id: id,
    },
    include: [
      {
        model: Job,
        include: {
          model: Industry,
        },
      },
    ],
  });

  // Count the amount of resume user have
  const resumesCount = await Resume.count({
    where: {
      user_id: id,
    },
  });

  const industriesIdsArray = appliedJobs.reduce((acc, apply) => {
    const industryIds = apply.Job.dataValues.Industries.map(
      (industry) => industry.id
    );
    return [...acc, ...industryIds];
  }, []);

  const uniqueIndustriesIdsArray = [...new Set(industriesIdsArray)];

  const industries = await Industry.findAll({
    where: {
      id: {
        [Op.in]: uniqueIndustriesIdsArray,
      },
    },
  });

  // Based on the industries, get the amount of jobs in each industry that user has applied
  const industryCount = industries.map((industry) => {
    const count = appliedJobs.filter((apply) =>
      apply.Job.Industries.some((jobIndustry) => jobIndustry.id === industry.id)
    ).length;
    return {
      name: industry.industry,
      count,
    };
  });

  const applyCountsByType = {
    pending: 0,
    "accepted-cv-round": 0,
    "accepted-interview-round": 0,
    rejected: 0,
  };

  // For each apply, count the amount of applies by type

  appliedJobs.forEach((apply) => {
    applyCountsByType[apply.status] += 1;
  });

  const statisticsArray = Object.entries(applyCountsByType).map(
    ([status, value]) => ({
      status,
      value,
    })
  );

  return res.status(200).json({
    status: "success",
    data: {
      statistics: {
        appliedJobsCount,
        bookmarkedJobsCount,
        resumesCount,
        appliedByIndustries: industryCount,
        applyCountsByType: statisticsArray,
      },
    },
  });
});

const catchAsync = require("../utils/catchAsync");
const AppError = require("../utils/appError");
const { Tag } = require("../models/databaseIndex");

exports.getAllTags = catchAsync(async (req, res, next) => {
  const tags = await Tag.findAll();

  return res.status(200).json({
    status: "success",
    data: {
      tags,
    },
  });
});

const catchAsync = require("../utils/catchAsync");
const AppError = require("../utils/appError");
const { Industry } = require("../models/databaseIndex");

exports.getAllIndustries = catchAsync(async (req, res, next) => {
  const industries = await Industry.findAll();

  if (!industries.length) return next(new AppError("No industries found", 404));

  return res.status(200).json({
    status: "success",
    data: {
      industries,
    },
  });
});

const catchAsync = require("../utils/catchAsync");
const AppError = require("../utils/appError");
const { Bookmark } = require("../models/databaseIndex");

exports.deleteBookmark = catchAsync(async (req, res, next) => {
  const { id } = req.params;

  const bookmark = await Bookmark.findByPk(id);

  if (!bookmark) return next(new AppError("Bookmark not found", 404));

  await bookmark.destroy();

  return res.status(204).json({
    status: "success",
    data: null,
  });
});

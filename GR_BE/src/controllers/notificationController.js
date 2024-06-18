const catchAsync = require("../utils/catchAsync");
const AppError = require("../utils/appError");
const { Notification } = require("../models/databaseIndex");

exports.createNotification = catchAsync(async (req, res, next) => {
  const data = { ...req.body };

  const notification = await Notification.create(data);

  return res.status(201).json({
    status: "success",
    data: {
      notification,
    },
  });
});

exports.getAllNotificationsByUserId = catchAsync(async (req, res, next) => {
  const userId = req.params.id;

  const notifications = await Notification.findAll({
    where: { receiver_id: userId },
    order: [["createdAt", "DESC"]],
  });

  return res.status(200).json({
    status: "success",
    data: {
      notifications,
    },
  });
});

exports.deleteAllNotificationByUserId = catchAsync(async (req, res, next) => {
  const userId = req.params.id;

  await Notification.destroy({
    where: { receiver_id: userId },
  });

  return res.status(204).json({
    status: "success",
    data: null,
  });
});

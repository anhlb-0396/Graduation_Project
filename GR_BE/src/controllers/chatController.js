const catchAsync = require("../utils/catchAsync");
const AppError = require("../utils/appError");
const { Chat, User, Op } = require("../models/databaseIndex");

exports.createChat = catchAsync(async (req, res, next) => {
  const data = { ...req.body };

  const chat = await Chat.create(data);

  return res.status(201).json({
    status: "success",
    data: {
      chat,
    },
  });
});

exports.getAllChatsByUserId = catchAsync(async (req, res, next) => {
  const userId = req.params.id;

  const chats = await Chat.findAll({
    where: {
      [Op.or]: [{ sender_id: userId }, { receiver_id: userId }],
    },
  });

  return res.status(200).json({
    status: "success",
    data: {
      chats,
    },
  });
});

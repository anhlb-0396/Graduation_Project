const catchAsync = require("../utils/catchAsync");
const AppError = require("../utils/appError");
const { Apply, User, Job } = require("../models/databaseIndex");
const { transporter } = require("../config/mailConfig");

exports.updateApply = catchAsync(async (req, res, next) => {
  const { id } = req.params;
  const data = { ...req.body };

  const apply = await Apply.findByPk(id);

  if (!apply) return next(new AppError("Apply not found", 404));

  const updatedApply = {
    status: data.status,
    response: data.response,
  };

  await apply.update(updatedApply);

  if (data.status === "accepted-interview-round") {
    const job_id = data.job_id;
    const job = await Job.findByPk(job_id);
    if (!job) return next(new AppError("Job not found", 404));
    await job.update({ recruitment_number: job.recruitment_number - 1 });
  }

  const { sender_id, receiver_id, message, response } = data;

  const senderUser = await User.findByPk(sender_id);
  const receiverUser = await User.findByPk(receiver_id);

  const mailOptions = {
    from: senderUser.gmail,
    to: receiverUser.gmail,
    subject: message,
    html: response,
  };

  await transporter.sendMail(mailOptions);

  res.status(200).json({
    status: "success",
    data: {
      apply,
    },
  });
});

exports.deleteApply = catchAsync(async (req, res, next) => {
  const { id } = req.params;

  const apply = await Apply.findByPk(id);

  if (!apply) return next(new AppError("Apply not found", 404));

  await apply.destroy();

  res.status(204).json({
    status: "success",
    data: null,
  });
});

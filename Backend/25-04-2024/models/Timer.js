const mongoose = require('mongoose');

const timerSchema = new mongoose.Schema({
  wish: String,
  startTime: Number,
  duration: Number,
});

module.exports = mongoose.model('Timer', timerSchema);

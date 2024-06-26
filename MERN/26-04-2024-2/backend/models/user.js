const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
  username: { type: String, required: true },
});

const userModel = mongoose.model('userModel', userSchema);

module.exports = userModel;

const express = require('express');
const router = express.Router();
const userModel = require('../models/user');

router.post('/add-user', async (req, res) => {
  const user = new userModel(req.body);
  try {
    await user.save();
    //   Always call your function
    res.status(201).json({
      status: 'Success',
      data: {
        username: user.username,
        firstName: user.firstName,
      },
    });
  } catch (error) {
    res.status(404).json({
      status: 'Failed',
      message: error,
    });
  }
});

router.get('/get-users', async (req, res) => {
  const allUsers = await userModel.find({});
  // Remember the notations

  try {
    res.status(200).json({
      status: 'Success',
      data: { allUsers },
    });
  } catch (error) {
    res.status(500).json({
      status: 'Failed',
      message: error,
    });
  }
});

// Always call your router
module.exports = router;

const express = require('express');
const router = express.Router();

const userModel = require('../models/user');

router.post('/add-user', async (req, res) => {
  const user = new userModel(req.body);
  try {
    res.status(201).json({
      status: 'Success',
      data: user,
    });
  } catch (error) {
    res.status(404).json({
      status: 'Failed',
      message: error,
    });
  }
});

router.get('/get-users', async (req, res) => {
  const users = userModel.find([]);
  try {
    res.status(201).json({
      status: 'Success',
      data: {
        users,
      },
    });
  } catch (error) {
    res.status(500).json({
      status: 'Failed',
      messsage: error,
    });
  }
});

module.exports = router;

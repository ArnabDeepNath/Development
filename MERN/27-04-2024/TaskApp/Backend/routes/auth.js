const express = require('express');
const router = express.Router();
const userModel = require('../model/user');
const taskModel = require('../model/task');

// User Register -> Might use a similar model for task
router.post('/register', async (req, res) => {
  const user = new userModel(req.body);
  try {
    await user.save();
    res.status(201).json({
      status: 'Success',
      data: {
        username: user.username,
        password: user.password,
      },
    });
  } catch (error) {
    res.status(500).json({
      status: 'Failed',
      message: error,
    });
  }
});

// View all user -> dashboard settings

router.get('/viewAll', async (req, res) => {
  const allUsers = await userModel.find({});
  try {
    res.status(200).json({
      status: 'Success',
      data: allUsers,
    });
  } catch (error) {
    res.status(500).json({
      status: 'Failed',
      message: error,
    });
  }
});

// Update User Details
router.patch('/updateUser/:id', async (req, res) => {
  const updatedUsers = await userModel.findByIdAndUpdate(
    req.params.id,
    req.body,
    {
      new: true,
      runValidators: true,
    },
  );
  try {
    res.status(200).json({
      status: 'Success',
      data: updatedUsers,
    });
  } catch (error) {
    res.status(500).json({
      status: 'Failed',
      message: error,
    });
  }
});

// DeleteUser
router.delete('/deleteUser/:id', async (req, res) => {
  await userModel.findByIdAndDelete(req.params.id);

  try {
    res.status(200).json({
      status: 'Success',
      data: {},
    });
  } catch (error) {
    res.status(500).json({
      status: 'Failed',
      message: error,
    });
  }
});

// Task Model , Add Task API

router.post('/addTask', async (req, res) => {
  const task = new taskModel(req.body);
  await task.save();
  try {
    res.status(201).json({
      status: 'Success',
      data: task,
    });
  } catch (error) {
    res.status(500).json({
      status: 'Failed',
      message: error,
    });
  }
});

// Task Model , View All Tasks by userID

router.get('/viewTask', async (req, res) => {
  const allTasks = await taskModel.find({});
  try {
    res.status(200).json({
      status: 'Success',
      data: allTasks,
    });
  } catch (error) {
    res.status(500).json({
      status: 'Failed',
      message: error,
    });
  }
});

// Task Model , Updating a task by ID

router.patch('/updateTask/:id', async (req, res) => {
  const updatedTask = await taskModel.findByIdAndUpdate(
    req.params.id,
    req.body,
    {
      new: true,
      useValidators: true,
    },
  );
  try {
    res.status(200).json({
      status: 'Success',
      data: updatedTask,
    });
  } catch (error) {
    res.status(500).json({
      status: 'Failed',
      message: error,
    });
  }
});

// Task Model , Deleting a Task by ID

router.delete('/deleteTask/:id', async (req, res) => {
  await taskModel.findByIdAndDelete(req.params.id);

  try {
    res.status(200).json({
      status: 'Success',
      data: {},
    });
  } catch (error) {
    res.status(500).json({
      status: 'Failed',
      message: error,
    });
  }
});

// We need to implement login facility and desing the frontend

module.exports = router;

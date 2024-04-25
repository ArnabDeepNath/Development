const mongoose = require('mongoose');
const cors = require('cors');
const express = require('express');
const User = require('./models/user');
const app = express();

app.use(cors());
app.use(express.json());

const PORT = 8000;

app.listen(PORT, () => {
  console.log('Port is running on ', PORT);
});

const DB =
  'mongodb+srv://arnab:21Jan2024@cluster0.svfel.mongodb.net/crudDB?retryWrites=true&w=majority&appName=Cluster0';

mongoose
  .connect(DB, {
    useUnifiedTopology: true,
    useNewUrlParser: true,
  })
  .then(console.log('Database conneted'));

app.post('/add-user', async (req, res) => {
  const newUser = new User(req.body);
  try {
    await newUser.save();
    res.status(201).json({
      status: 'Success',
      data: {
        newUser,
      },
    });
  } catch (error) {
    res.status(500).json({
      status: 'Failed',
      message: error,
    });
  }
});

app.get('/get-users', async (req, res) => {
  const allUsers = await User.find({});
  try {
    res.status(201).json({
      status: 'Success',
      data: {
        allUsers,
      },
    });
  } catch (error) {
    res.status(500).json({
      status: 'failed',
      message: error,
    });
  }
});

const express = require('express');
const cors = require('cors');
const mongoose = require('mongoose');
const authRoutes = require('./routes/auth');

const app = express();

app.use(cors());
app.use(express.json());
app.use('/auth', authRoutes);

const PORT = 3000;

app.listen(PORT, () => {
  console.log('Server is running on port: ', PORT);
});

MONGODB_URI =
  'mongodb+srv://arnab:21Jan2024@cluster0.svfel.mongodb.net/taskApp?retryWrites=true&w=majority&appName=Cluster0';

mongoose
  .connect(MONGODB_URI, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
  })
  .then(console.log('Mongo DB Connected'));

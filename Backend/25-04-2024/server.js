// Importing modules

const express = require('express');
const dotenv = require('dotenv');
const mongoose = require('mongoose');
const authRoutes = require('./routes/auth');
const timerRoutes = require('./routes/timer');

// Setting up environment varibales
dotenv.config();

//  creating instance of express
const app = express();

// COnnect to mongodb

mongoose
  .connect(process.env.MONGODB_URI, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
  })
  .then(() => console.log('COnnect to MongoDB'))
  .catch((err) => console.log('Error connected to MOngoDB', err));

// Middleware to parse incoming JSON requests
app.use(express.json());

// Routes
app.use('/auth', authRoutes);
app.use('/timer', timerRoutes);

// Start the server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log('Connected to port:', PORT);
});

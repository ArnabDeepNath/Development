const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
const app = express();
const authRouter = require('./routes/auth');
app.use(cors());
app.use(express.json());

app.use('/auth', authRouter);

const mongoUrl =
  'mongodb+srv://arnab:21Jan2024@cluster0.svfel.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0';
mongoose
  .connect(mongoUrl, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
  })
  .then(console.log('Mongo Drive Connected'));
const PORT = 3000;
app.listen(PORT, () => {
  console.log('Port is running on ', PORT);
});

const mongoose = require('mongoose');

const connection = mongoose
  .createConnection(
    'mongodb+srv://arnab:21J%40n1421@cluster0.svfel.mongodb.net/inmytouch',
  )
  .on('open', () => {
    console.log('Mongo DB Connected');
  });

module.exports = connection;

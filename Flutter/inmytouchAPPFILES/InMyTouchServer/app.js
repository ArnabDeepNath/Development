const express = require('express');
const body_parser = require('body-parser');
const UserRoute = require('./routes/user_routes');
const app = express();
app.use(body_parser.json());
app.use('/', UserRoute);
module.exports = app;

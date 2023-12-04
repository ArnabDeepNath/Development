const app = require('./app');
const db = require('./config/db');
const UserModel = require('./models/user_model');
const port = 3000;

app.get('/', (req, res) => {
  res.send('Inmytouch Server');
});
app.listen(port, () => {
  console.log(`Server is running on port http://localhost:${port}`);
});

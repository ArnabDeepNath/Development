const router = require('express').Router();

const UserController = require('../controllers/user_controller');

router.post('/registration', UserController.register);

module.exports = router;

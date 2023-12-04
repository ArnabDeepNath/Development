const UserService = require('../services/user_services');

exports.register = async (req, res, next) => {
  try {
    const { email, password, firstName, lastName } = req.body;
    const successRes = await UserService.registerUser(
      email,
      password,
      firstName,
      lastName,
    );
    res.json({ status: true, success: 'User Registered Succesfully' });
  } catch (error) {
    throw error;
  }
};

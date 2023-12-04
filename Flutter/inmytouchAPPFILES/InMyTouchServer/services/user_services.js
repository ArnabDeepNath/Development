const UserModel = require('../models/user_model');

class UserService {
  static async registerUser(email, password, firstName, lastName) {
    try {
      const createUser = new UserModel({
        email,
        password,
        firstName,
        lastName,
      });
      return await createUser.save();
    } catch (error) {
      throw error;
    }
  }
}

module.exports = UserService;

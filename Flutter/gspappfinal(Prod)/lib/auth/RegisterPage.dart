import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gspappfinal/auth/AuthController.dart';
import 'package:gspappfinal/auth/LoginPage.dart';
import 'package:gspappfinal/components/TextFormField.dart';
import 'package:gspappfinal/constants/AppColor.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController UserEmailController = TextEditingController();
  TextEditingController UserPassController = TextEditingController();
  TextEditingController UserContactNumber = TextEditingController();
  TextEditingController UserFirstName = TextEditingController();
  TextEditingController UserSecondName = TextEditingController();

  bool isLoading = false;
  void clear() {
    setState(() {
      UserEmailController.clear();
      UserPassController.clear();
      UserContactNumber.clear();
      UserFirstName.clear();
      UserSecondName.clear();
    });
  }

  String? nonEmptyValidator(String? value) {
    if (value != null && value.isNotEmpty) {
      return null; // Field is not empty, so it's valid.
    }

    // Field is empty, so return an error message.
    return 'This field cannot be empty';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Sign Up',
                    style: GoogleFonts.inter(
                      fontSize: 54,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 22,
                ),
                TextFormFieldCustom(
                  validator: nonEmptyValidator,
                  label: 'First Name',
                  controller: UserFirstName,
                  onChange: (String) {},
                  obscureText: false,
                ),
                TextFormFieldCustom(
                  validator: nonEmptyValidator,
                  label: 'Second Name',
                  controller: UserSecondName,
                  onChange: (String) {},
                  obscureText: false,
                ),
                TextFormFieldCustom(
                  validator: nonEmptyValidator,
                  label: 'Email',
                  controller: UserEmailController,
                  onChange: (String) {},
                  obscureText: false,
                ),
                TextFormFieldCustom(
                  validator: nonEmptyValidator,
                  label: 'Password',
                  controller: UserPassController,
                  onChange: (String) {},
                  obscureText: true,
                ),
                TextFormFieldCustom(
                  validator: nonEmptyValidator,
                  label: 'Contact Number',
                  controller: UserContactNumber,
                  onChange: (String) {},
                  obscureText: false,
                ),
                SizedBox(
                  height: 22,
                ),
                Center(
                  child: InkWell(
                    onTap: () async {
                      AuthController authController =
                          AuthController(); // Create an instance of AuthController
                      try {
                        // Call the registerUser function and pass the user information
                        await authController.registerUser(
                          firstName: UserFirstName.text,
                          secondName: UserSecondName.text,
                          email: UserEmailController.text,
                          password: UserPassController.text,
                          contact: UserContactNumber.text,
                          // Add other user details as needed
                        );

                        // Registration successful, you can navigate to another page or show a success message.
                        clear();
                        print('User Added Succesfully');
                      } catch (e) {
                        // Handle registration errors, e.g., show an error message.
                        print('Error during registration: $e');
                      }
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.06,
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3), // Shadow color
                            // Shadow color
                            offset: const Offset(0, 2), // Offset of the shadow
                            blurRadius: 4, // Blur radius of the shadow
                            spreadRadius: 1, // Spread radius of the shadow
                          ),
                        ],
                      ),
                      child: Center(
                        child: isLoading
                            ? CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              )
                            : Text(
                                'Sign Up',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already registered ? ',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      InkWell(
                        child: Text(
                          'Sign In Now',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gspappfinal/auth/AuthController.dart';
import 'package:gspappfinal/auth/RegisterPage.dart';
import 'package:gspappfinal/components/TextFormField.dart';
import 'package:gspappfinal/constants/AppColor.dart';
import 'package:gspappfinal/views/MainDashboard.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController UserEmailController = TextEditingController();
  TextEditingController UserPassController = TextEditingController();
  bool isLoading = false;
  void clear() {
    UserEmailController.clear();
    UserPassController.clear();
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
      appBar: AppBar(
        title: const Text(
          'Sign In',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        backgroundColor: AppColors.secondaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.20,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.black,
                      ),
                      child: Center(
                        child: Image(
                          height: 30,
                          image: NetworkImage(
                            'https://upload.wikimedia.org/wikipedia/commons/thumb/3/31/Apple_logo_white.svg/1724px-Apple_logo_white.svg.png',
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.blue,
                      ),
                      child: Center(
                        child: Image(
                          height: 80,
                          image: NetworkImage(
                            'https://i0.wp.com/gethsemanebaptistchurch.org/wp-content/uploads/2019/05/facebook-logo-png-transparent-background-1024x1024.png?ssl=1',
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                        border: Border.all(color: Colors.orange),
                      ),
                      child: Center(
                        child: Image(
                          height: 40,
                          image: NetworkImage(
                            'https://www.freepnglogos.com/uploads/google-logo-png/google-logo-png-webinar-optimizing-for-success-google-business-webinar-13.png',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Divider(
                      color: Colors.black.withOpacity(0.6),
                      thickness: 0.8,
                      indent: 10,
                      endIndent: 10,
                    ),
                  ),
                  Text(
                    'or',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black.withOpacity(0.4),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.black,
                      thickness: 0.8,
                      indent: 10,
                      endIndent: 10,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 22,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Enter Your Credentials',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black.withOpacity(0.8),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Connect this device to your account',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black.withOpacity(0.6),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
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
              const SizedBox(
                height: 22,
              ),
              Center(
                child: InkWell(
                  onTap: () async {
                    setState(() {
                      isLoading = true; // Set loading state to true
                    });

                    User? user = await AuthController().loginUser(
                      email: UserEmailController.text,
                      password: UserPassController.text,
                    );

                    setState(() {
                      isLoading =
                          false; // Set loading state to false after login attempt
                    });

                    if (user != null) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MainDashboard(
                            userID: user.uid,
                          ),
                        ),
                      );
                    } else {
                      print('Some Error occurred');
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
                              'Sign In',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              InkWell(
                child: Text(
                  'Forgot Password ?',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
                onTap: () {},
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have a account ? ",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54,
                      ),
                    ),
                    InkWell(
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => RegisterPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 85,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                          text:
                              'By continuing , you agree that you have read and accept our '),
                      TextSpan(
                        text: 'Terms and Conditions',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

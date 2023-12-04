import 'package:flutter/material.dart';
import 'package:mvc_app/controller/authController.dart';
import 'package:mvc_app/view/loginPage.dart';

class registerPage extends StatefulWidget {
  const registerPage({super.key});

  @override
  State<registerPage> createState() => _registerPageState();
}

class _registerPageState extends State<registerPage> {
  final _formKey = GlobalKey<FormState>();
  FirebaseAuthService authService = FirebaseAuthService();
  late String _name = '';
  late String _email = '';
  late String _pass = '';
  late String _address = '';
  late String _crmid = '';
  late String _phone = '';
  late String _id = '';
  late String _role = '';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 22,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade200,
                            offset: Offset(0.0, 1.0),
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 22,
                        ),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Name',
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            _name = value;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a valid Name';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white,
                            offset: Offset(0.0, 1.0),
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 22,
                        ),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'CRM ID',
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            _crmid = value;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a valid CRM ID';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white,
                            offset: Offset(0.0, 1.0),
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 22,
                        ),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Email',
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            _email = value;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a valid Email';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white,
                            offset: Offset(0.0, 1.0),
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 22,
                        ),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Password',
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            _pass = value;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a valid Password';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white,
                            offset: Offset(0.0, 1.0),
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 22,
                        ),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Phone Number',
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            _phone = value;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a valid Phone Number';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white,
                            offset: Offset(0.0, 1.0),
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 22,
                        ),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Address',
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            _address = value;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a valid Address';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    MaterialButton(
                      color: Colors.blue[400],
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          try {
                            FirebaseAuthService authService =
                                FirebaseAuthService();
                            authService.registerUser(
                              _email,
                              _pass,
                              _crmid,
                              _phone,
                              _name,
                              _id,
                              _address,
                              _role,
                            );
                            Navigator.pop(context);
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Success"),
                                  content:
                                      Text("User registered successfully."),
                                  actions: <Widget>[
                                    MaterialButton(
                                      child: Text("OK"),
                                      onPressed: () {
                                        // Return to the login page
                                        authService.signOut();
                                        Navigator.of(context).pop();
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => loginPage(),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                            setState(() {
                              _formKey.currentState!.reset();
                            });
                          } catch (error) {
                            // Show an error message if there's an issue adding the car
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Error adding User: $error'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          } // Show
                        }
                      },
                      child: const Text(
                        'Register Now',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

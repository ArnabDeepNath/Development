import 'package:flutter/material.dart';
import 'package:mvc_app/controller/authController.dart';
import 'package:mvc_app/view/UserPanel.dart';
import 'package:mvc_app/view/registerPage.dart';

class loginPage extends StatefulWidget {
  loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  bool _isLoading = false;

  late String _pass;
  late String _crmid;
  late String _role;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 22,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Mithila Motors',
                  style: TextStyle(
                    color: Colors.blue[400],
                    fontWeight: FontWeight.bold,
                    fontSize: 44,
                  ),
                ),
                SizedBox(
                  height: 22,
                ),
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
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'CRM ID',
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        _crmid = value + '@mithilamotors.com';
                      },
                    ),
                  ),
                ),
                // const SizedBox(
                //   height: 22,
                // ),
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
                    child: TextField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        _pass = value;
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 22,
                ),
                MaterialButton(
                  elevation: 6.0,
                  color: Colors.blue[400],
                  onPressed: () async {
                    setState(() {
                      _isLoading = true;
                    });

                    FirebaseAuthService authService = FirebaseAuthService();
                    await authService.signIn(context, _crmid, _pass);

                    setState(() {
                      _isLoading = false;
                    });
                  },
                  child: _isLoading
                      ? CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                      : Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                ),

                SizedBox(
                  height: 22,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text('Not a Member Yet ?'),
                        SizedBox(
                          width: 22,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => registerPage(),
                              ),
                            );
                          },
                          child: Text(
                            'Register Now',
                            style: TextStyle(
                              color: Colors.blue[400],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 42,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('A property of Mithila Motors'),
                    SizedBox(
                      width: 22,
                    ),
                    Text('Copyright 2022-2023'),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

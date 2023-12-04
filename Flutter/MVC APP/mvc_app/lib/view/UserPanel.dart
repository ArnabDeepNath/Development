import 'package:flutter/material.dart';
import 'package:mvc_app/model/userModel.dart';
import 'package:mvc_app/view/carSettingsPage.dart';
import 'package:mvc_app/view/InvoicePage_Users.dart';
import 'package:mvc_app/view/UsersPage.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebaseAuth;
import 'package:mvc_app/view/loginPage.dart';
import 'package:mvc_app/view/userSettingsPage.dart';

import '../controller/authController.dart';

class MainPage extends StatefulWidget {
  MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  FirebaseAuthService authService = FirebaseAuthService();

  @override
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    InvoicePage_users(),
    userSettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var currentUser = authService.getCurrentUser();
    return Scaffold(
      appBar: AppBar(
        title: Text('Users Panel'),
        automaticallyImplyLeading: false,
        actions: [
          Row(
            children: [
              FutureBuilder<User>(
                future: authService.getCurrentUser(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text('Logged in as: ${snapshot.data!.name}');
                  } else {
                    return Text('Loading...');
                  }
                },
              ),
              IconButton(
                onPressed: () {
                  // handle logout button press here
                  authService.signOut();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => loginPage(),
                    ),
                  );
                },
                icon: Icon(Icons.logout),
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            label: 'Invoices',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}

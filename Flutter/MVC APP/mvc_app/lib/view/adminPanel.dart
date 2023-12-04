import 'package:flutter/material.dart';
import 'package:mvc_app/model/userModel.dart';
import 'package:mvc_app/view/InvoicePage_Admin.dart';
import 'package:mvc_app/view/carSettingsPage.dart';
import 'package:mvc_app/view/InvoicePage_Users.dart';
import 'package:mvc_app/view/UsersPage.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebaseAuth;
import 'package:mvc_app/view/loginPage.dart';

import '../controller/authController.dart';

class adminPanel extends StatefulWidget {
  adminPanel({super.key});

  @override
  State<adminPanel> createState() => _adminPanelState();
}

class _adminPanelState extends State<adminPanel> {
  FirebaseAuthService authService = FirebaseAuthService();

  @override
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    UsersPage(),
    InvoicePage_Admin(),
    CarSettingsPage(),
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
        title: Text('Admin Panel'),
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
            icon: Icon(Icons.person),
            label: 'Users',
          ),
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

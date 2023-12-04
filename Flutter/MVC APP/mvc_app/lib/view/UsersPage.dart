import 'package:flutter/material.dart';
import 'package:mvc_app/controller/usersController.dart';
import 'package:mvc_app/view/addInvoicePage_Non_GST.dart';
import 'package:mvc_app/view/loginPage.dart';
import 'package:mvc_app/view/registerPage.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => registerPage()));
            },
            child: Text('Add Users'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UserController()));
            },
            child: Text('View Users'),
          ),
        ],
      ),
    );
  }
}

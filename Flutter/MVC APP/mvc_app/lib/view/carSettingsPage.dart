import 'package:flutter/material.dart';
import 'package:mvc_app/view/addCarPage.dart';
import 'package:mvc_app/view/addInvoicePage_Non_GST.dart';
import 'package:mvc_app/view/carDetailsPage.dart';
import 'package:mvc_app/view/loginPage.dart';

class CarSettingsPage extends StatelessWidget {
  const CarSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddCarPage(),
                ),
              );
            },
            child: Text('Add Car Settings Manually'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => carDetailsPage(),
                ),
              );
            },
            child: Text('View Car Settings'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => carDetailsPage(),
                ),
              );
            },
            child: Text('Upload Car Data'),
          ),
        ],
      ),
    );
  }
}

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zerodha/src/repository/helpeaze_preference_provider.dart';
import 'package:zerodha/src/repository/repository.dart';

import 'dashboard_page.dart';

class SplashPage extends StatefulWidget {
  final Repository appRepository;
  final PreferenceProvider sharePreferenceProvider;
  final bool isLoggedin;

  const SplashPage(
      {required this.appRepository,
      required this.sharePreferenceProvider,
      required this.isLoggedin});

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2000), () {
      setState(() {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              settings: const RouteSettings(name: "/dashboardScreen"),
              builder: (context) => DashboardScreen(
                sharePreferenceProvider: widget.sharePreferenceProvider,
                appRepository: widget.appRepository,
              ),
            ));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(left: 10.0, right: 10.0),
        color: Colors.white,
        child: Center(
          child: Image.asset("assets/image/app_icon.png", height: MediaQuery.of(context).size.height*.4,  width: MediaQuery.of(context).size.width*.6),
        ),
      ),
    );
  }
}

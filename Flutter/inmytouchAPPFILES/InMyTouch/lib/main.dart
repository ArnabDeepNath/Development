import 'package:flutter/material.dart';
import 'package:inmytouch/views/Dashboard.dart';
import 'package:inmytouch/views/ForgotPassword.dart';
import 'package:inmytouch/views/LoginPage.dart';
import 'package:inmytouch/views/PasswordReset.dart';
import 'package:inmytouch/views/RegisterPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'inmytouch',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blueAccent.withOpacity(0.25)),
        useMaterial3: true,
      ),
      home: RegisterPage(),
    );
  }
}

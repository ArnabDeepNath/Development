import 'package:flutter/material.dart';
import 'package:gspappfinal/constants/AppColor.dart';

class UserTransactions extends StatefulWidget {
  const UserTransactions({super.key});

  @override
  State<UserTransactions> createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: Column(
        children: [
          Center(
            child: Text('Fuck that Bitch !!'),
          )
        ],
      ),
    );
  }
}

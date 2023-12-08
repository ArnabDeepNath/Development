import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gspappfinal/components/transactionCard.dart';
import 'package:gspappfinal/constants/AppColor.dart';
import 'package:gspappfinal/constants/AppTheme.dart';

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Your Transactions',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
          ),
          transactionCard(
            type: 'Sale',
            typeColor: Colors.red,
            amount: 500.0,
            balance: 155.0,
            name: 'Deepak',
          ),
          transactionCard(
            type: 'Pay',
            typeColor: Colors.green,
            amount: 8000.0,
            balance: 5.0,
            name: 'Deepak',
          ),
        ],
      ),
    );
  }
}

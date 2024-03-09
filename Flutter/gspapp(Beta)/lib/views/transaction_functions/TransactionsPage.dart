import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gspappfinal/constants/AppColor.dart';
import 'package:gspappfinal/controllers/PartyController.dart';
import 'package:gspappfinal/models/TransactionsModel.dart';
import 'package:gspappfinal/components/transactionCard.dart';

class UserTransactionsPage extends StatefulWidget {
  @override
  _UserTransactionsPageState createState() => _UserTransactionsPageState();
}

class _UserTransactionsPageState extends State<UserTransactionsPage> {
  late StreamController<List<TransactionsMain>> _streamController;
  List<TransactionsMain> _transactions = [];

  @override
  void initState() {
    super.initState();
    _streamController = StreamController<List<TransactionsMain>>();
    MainPartyController().getUserTransactions().listen((data) {
      if (mounted) {
        setState(() {
          _transactions = data;
        });
      }
    });
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: ListView.builder(
        itemCount: _transactions.length,
        itemBuilder: (context, index) {
          final transaction = _transactions[index];
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: transactionCard(
              amount: transaction.amount,
              balance: transaction.balance,
              name: transaction.recieverName,
              transactionType: transaction.transactionType,
              partyId: transaction.recieverId,
              userId: transaction.sender!,
              transactionId: transaction.transactionId,
              isEditable: transaction.isEditable,
            ),
          );
        },
      ),
    );
  }
}

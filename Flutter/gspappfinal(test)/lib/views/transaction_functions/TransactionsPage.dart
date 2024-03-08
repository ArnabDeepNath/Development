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

  @override
  void initState() {
    super.initState();
    _streamController = StreamController<List<TransactionsMain>>();
    MainPartyController().getUserTransactions().listen((data) {
      _streamController.add(data);
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
      body: StreamBuilder<List<TransactionsMain>>(
        stream: _streamController.stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'No transactions found.',
                style: GoogleFonts.inter(
                  fontSize: 18,
                ),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final transaction = snapshot.data![index];
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
            );
          }
        },
      ),
    );
  }
}

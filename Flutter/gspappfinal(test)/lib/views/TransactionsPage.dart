import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gspappfinal/constants/AppColor.dart';
import 'package:gspappfinal/controllers/PartyController.dart';
import 'package:gspappfinal/models/TransactionsModel.dart';

import 'package:gspappfinal/components/transactionCard.dart';

class UserTransactionsPage extends StatelessWidget {
  const UserTransactionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: StreamBuilder<List<TransactionsMain>>(
        stream: MainPartyController()
            .getUserTransactions(), // Replace with your controller
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Text('No transactions found.');
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

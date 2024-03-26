import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BalanceProvider extends ChangeNotifier {
  Stream<double> getTotalReceiveBalanceStream(String userId) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('parties')
        .snapshots()
        .asyncMap((partySnapshot) async {
      double totalBalance = 0.0;

      for (var partyDoc in partySnapshot.docs) {
        var partyId = partyDoc.id;

        var partyTransactions = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('parties')
            .doc(partyId)
            .collection('transactions')
            .where('transactionType', isEqualTo: 'pay')
            .get();

        print('Party Transactions: ${partyTransactions.docs.length}');

        for (var doc in partyTransactions.docs) {
          var transactionData = doc.data();
          print('Transaction Data: $transactionData');
          var transactionAmount = transactionData['amount'] ?? 0.0;
          totalBalance += transactionAmount;
        }
      }

      print('Total Balance: $totalBalance');
      return totalBalance;
    });
  }

  Stream<double> getTotalPayBalanceStream(String userId) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('parties')
        .snapshots()
        .asyncMap((partySnapshot) async {
      double totalBalance = 0.0;

      for (var partyDoc in partySnapshot.docs) {
        var partyId = partyDoc.id;

        var partyTransactions = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('parties')
            .doc(partyId)
            .collection('transactions')
            .where('transactionType', isEqualTo: 'recieve')
            .get();

        print('Party Transactions: ${partyTransactions.docs.length}');

        for (var doc in partyTransactions.docs) {
          var transactionData = doc.data();
          print('Transaction Data: $transactionData');
          var transactionAmount = transactionData['amount'] ?? 0.0;
          totalBalance += transactionAmount;
        }
      }

      print('Total Balance: $totalBalance');
      return totalBalance;
    });
  }
}

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gspappfinal/models/TransactionsModel.dart';

class BalanceProvider extends ChangeNotifier {
  double _balance = 0.0;
  final StreamController<double> _balanceController =
      StreamController<double>.broadcast();

  double get balance => _balance;

  Stream<double> get balanceStream => _balanceController.stream;

  void dispose() {
    _balanceController.close();
    super.dispose();
  }

  void updateBalance(double amount) {
    _balance += amount;
    _balanceController.add(_balance);
  }

  Stream<double> getTotalBalanceStream(String userId) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('parties')
        .snapshots()
        .map((snapshot) {
      double totalBalance = 0.0;
      for (var doc in snapshot.docs) {
        totalBalance += doc.data()['balance'] ?? 0.0;
      }
      return totalBalance;
    });
  }
}

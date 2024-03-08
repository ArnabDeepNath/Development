import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gspappfinal/models/TransactionsModel.dart';
import 'dart:async';

class CalcUtil {
  final StreamController<Map<String, dynamic>> _totalReceivedAmountController =
      StreamController<Map<String, dynamic>>();
  Stream<Map<String, dynamic>> get totalReceivedAmountStream =>
      _totalReceivedAmountController.stream;

  final StreamController<Map<String, dynamic>> _totalPayAmountController =
      StreamController<Map<String, dynamic>>();
  Stream<Map<String, dynamic>> get totalPayAmountStream =>
      _totalPayAmountController.stream;

  void dispose() {
    _totalReceivedAmountController.close();
    _totalPayAmountController.close();
  }

  void calculateTotalPayAmount(String userId) {
    try {
      final userDocRef =
          FirebaseFirestore.instance.collection('users').doc(userId);
      final partiesCollection = userDocRef.collection('parties');

      partiesCollection.snapshots().listen((partySnapshot) async {
        double totalPayAmount = 0.0;
        int totalTransactionCount = 0;

        for (var partyDoc in partySnapshot.docs) {
          var partyId = partyDoc.id;
          var transactionsCollection =
              partiesCollection.doc(partyId).collection('transactions');

          var partyTransactions = await transactionsCollection
              .where('sender', isEqualTo: userId)
              .where('transactionType', isEqualTo: 'pay')
              .get();

          var receivedTransactions = partyTransactions.docs
              .map((doc) => TransactionsMain.fromMap(doc.data()))
              .toList();

          totalTransactionCount += receivedTransactions.length;

          for (var transaction in receivedTransactions) {
            totalPayAmount += transaction.amount;
          }
        }

        // Assuming _totalPayAmountController is a StreamController<Map<String, dynamic>>
        _totalPayAmountController.add({
          'totalPayAmount': totalPayAmount,
          'transactionCount': totalTransactionCount,
        });
      });
    } catch (e) {
      print('Error calculating total pay amount: $e');
      throw e;
    }
  }

  void calculateTotalRecievedAmount(String userId) {
    try {
      final userDocRef =
          FirebaseFirestore.instance.collection('users').doc(userId);
      final partiesCollection = userDocRef.collection('parties');

      partiesCollection.snapshots().listen((partySnapshot) async {
        double totalAmount = 0.0;
        int totalTransactionCount = 0;

        for (var partyDoc in partySnapshot.docs) {
          var partyId = partyDoc.id;
          var transactionsCollection =
              partiesCollection.doc(partyId).collection('transactions');

          var partyTransactions = await transactionsCollection
              .where('sender', isEqualTo: userId)
              .where('transactionType', isEqualTo: 'recieve')
              .get();

          var receivedTransactions = partyTransactions.docs
              .map((doc) => TransactionsMain.fromMap(doc.data()))
              .toList();

          totalTransactionCount += receivedTransactions.length;

          for (var transaction in receivedTransactions) {
            totalAmount += transaction.amount;
          }
        }

        // Assuming _totalReceivedAmountController is a StreamController<Map<String, dynamic>>
        _totalReceivedAmountController.add({
          'totalAmount': totalAmount,
          'transactionCount': totalTransactionCount,
        });
      });
    } catch (e) {
      print('Error calculating total received amount: $e');
      throw e;
    }
  }
}

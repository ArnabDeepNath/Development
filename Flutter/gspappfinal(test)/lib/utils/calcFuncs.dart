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
      final transactionsCollection = userDocRef.collection('transactions');

      transactionsCollection
          .where('sender', isEqualTo: userId)
          .where('transactionType', isEqualTo: 'pay')
          .snapshots()
          .listen((QuerySnapshot<Map<String, dynamic>> snapshot) {
        final receivedTransactions = snapshot.docs
            .map((doc) => TransactionsMain.fromMap(doc.data()))
            .toList();

        double totalAmount = 0.0;
        int transactionCount = receivedTransactions.length;

        for (var transaction in receivedTransactions) {
          totalAmount += transaction.amount ?? 0.0;
        }

        // Add data to the stream
        _totalPayAmountController.add({
          'totalAmount': totalAmount,
          'transactionCount': transactionCount,
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
      final transactionsCollection = userDocRef.collection('transactions');

      transactionsCollection
          .where('sender', isEqualTo: userId)
          .where('transactionType', isEqualTo: 'recieve')
          .snapshots()
          .listen((QuerySnapshot<Map<String, dynamic>> snapshot) {
        final receivedTransactions = snapshot.docs
            .map((doc) => TransactionsMain.fromMap(doc.data()))
            .toList();

        double totalAmount = 0.0;
        int transactionCount = receivedTransactions.length;

        for (var transaction in receivedTransactions) {
          totalAmount += transaction.amount ?? 0.0;
        }

        // Add data to the stream
        _totalReceivedAmountController.add({
          'totalAmount': totalAmount,
          'transactionCount': transactionCount,
        });
      });
    } catch (e) {
      print('Error calculating total pay amount: $e');
      throw e;
    }
  }
}

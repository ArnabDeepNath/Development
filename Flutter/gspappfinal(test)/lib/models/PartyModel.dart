import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gspappfinal/models/TransactionsModel.dart';

class Party {
  final String id;
  final String name;
  final String contactNumber;
  final Timestamp creationDate;
  final String GSTID;
  final String BillingAddress;
  final String EmailAddress;
  final String paymentType;
  final String balanceType;
  var balance;
  List<TransactionsMain> transactions;
  final String GSTType;
  final String POS;

  Party({
    required this.id,
    required this.name,
    required this.contactNumber,
    required this.balance,
    required this.transactions,
    required this.creationDate,
    required this.BillingAddress,
    required this.EmailAddress,
    required this.GSTID,
    required this.balanceType,
    required this.paymentType,
    required this.GSTType,
    required this.POS,
  });
}

class Transaction {
  final double amount;
  final DateTime date;

  Transaction({
    required this.amount,
    required this.date,
  });
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gspappfinal/controllers/PartyController.dart';
import 'package:gspappfinal/models/TransactionsModel.dart';

class AddSalePage extends StatefulWidget {
  final String partyId;
  final double currentBalance;
  final String partyName;

  AddSalePage({
    required this.partyId,
    required this.currentBalance,
    required this.partyName,
  });

  @override
  _AddSalePageState createState() => _AddSalePageState();
}

class _AddSalePageState extends State<AddSalePage> {
  final TextEditingController _amountController = TextEditingController();
  double? _saleAmount;
  String? getCurrentUserUid() {
    final User? user = FirebaseAuth.instance.currentUser;
    return user?.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Sale'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _amountController,
              decoration: InputDecoration(
                labelText: 'Sale Amount',
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_amountController.text.isNotEmpty) {
                  _saleAmount = double.tryParse(_amountController.text);
                  if (_saleAmount != null) {
                    _addTransaction();
                  }
                }
              },
              child: Text('Add Sale'),
            ),
          ],
        ),
      ),
    );
  }

  void _addTransaction() {
    final MainPartyController partyController = MainPartyController();

    // Calculate the updated balance
    final double updatedBalance = widget.currentBalance - _saleAmount!;
    String? userId = getCurrentUserUid();
    // Create a new transaction
    final TransactionsMain transaction = TransactionsMain(
        amount: _saleAmount!,
        description: '',
        timestamp: Timestamp.fromMicrosecondsSinceEpoch(0),
        sender: userId,
        reciever: widget.partyId,
        isEditable: false,
        balance: 0.0,
        recieverName: widget.partyName,
        recieverId: widget.partyId,
        transactionType: '',
        transactionId: ''
        // Add any other necessary details for the transaction
        );

    // Call the controller to add the transaction
    // partyController.addTransactionToParty(widget.partyId, transaction, userId!);

    // // Update the party's balance
    // partyController.updatePartyBalance(widget.partyId, updatedBalance, userId);

    partyController.addTransactionToUser(userId!, transaction);

    Navigator.pop(context, updatedBalance);
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }
}

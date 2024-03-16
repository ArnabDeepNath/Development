import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gspappfinal/models/TransactionsModel.dart';
import 'package:gspappfinal/models/PartyModel.dart';

class MainPartyController {
  final CollectionReference partiesCollection =
      FirebaseFirestore.instance.collection('parties');
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  // Updated to return a stream of parties
  Stream<List<Party>> partiesStream(String userId) {
    // Reference the user's document

    final userDocRef = usersCollection.doc(userId);

    return userDocRef.collection('parties').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return Party(
          id: doc.id,
          name: data['name'] ?? '',
          contactNumber: data['contactNumber'] ?? '',
          balance: data['balance'] ?? 0.0,
          transactions: [],
          BillingAddress: data['billingAddress'] ?? '',
          EmailAddress: data['emailAddress'] ?? '',
          GSTID: data['gstID'] ?? '',
          paymentType: data['paymentType'] ?? '',
          balanceType: data['balanceType'] ?? '',
          creationDate: data['creationDate'],
          GSTType: data['GSTType'] ?? '',
          POS: data['POS'] ?? '',
        );
      }).toList();
    });
  }

  Future<String> addParty(Party party, String userId) async {
    try {
      // Reference the user's document
      final userDocRef = usersCollection.doc(userId);

      // Create a new party document within the user's 'parties' subcollection
      final docRef = await userDocRef.collection('parties').add({
        'name': party.name,
        'contactNumber': party.contactNumber,
        'balance': party.balance,
        'billingAddress': party.BillingAddress,
        'emailAddress': party.EmailAddress,
        'gstId': party.GSTID,
        'paymentType': party.paymentType,
        'balanceType': party.balanceType,
        'creationDate': party.creationDate,
        'GSTType': party.GSTType,
        'POS': party.POS,
      });

      // Return the partyId
      return docRef.id;
    } catch (e) {
      print('Error adding party: $e');
      throw e;
    }
  }

  Future<void> addTransactionToParty(
      String partyId, TransactionsMain transactionMain, String userId) async {
    try {
      // Reference the user's document
      final userDocRef = usersCollection.doc(userId);

      // Create a new transaction document within the user's party's subcollection
      final DocumentReference partyTransactionDocRef = await userDocRef
          .collection('parties')
          .doc(partyId)
          .collection('transactions')
          .add(transactionMain.toMap());

      // Capture the transaction ID
      final String transactionId = partyTransactionDocRef.id;

      // Update the transaction document with its ID
      await partyTransactionDocRef.update({'transactionId': transactionId});

      // Also, add the transaction to the user's general transactions subcollection
      // This part was causing the error | 28-01-2024
      // await userDocRef.collection('transactions').add({
      //   ...transactionMain.toMap(),
      //   'transactionId': transactionId,
      // });
    } catch (e) {
      print('Error adding transaction: $e');
      throw e;
    }
  }

  Future<void> updatePartyBalance(
      String partyId, double newBalance, String userId) async {
    try {
      // Reference the user's document
      final userDocRef = usersCollection.doc(userId);

      // Update the balance of the party document within the user's party's subcollection
      await userDocRef.collection('parties').doc(partyId).update({
        'balance': newBalance,
      });
    } catch (e) {
      print('Error updating party balance: $e');
      throw e;
    }
  }

  Future<void> addTransactionToUser(
      String userId, TransactionsMain transactionMain) async {
    try {
      // Reference the user's document
      final userDocRef = usersCollection.doc(userId);

      // Create a new transaction document within the user's subcollection
      final DocumentReference transactionDocRef = await userDocRef
          .collection('transactions')
          .add(transactionMain.toMap());

      // Retrieve the ID of the newly added document
      final String transactionId = transactionDocRef.id;

      // Update the transaction document with its ID
      await transactionDocRef.update({'transactionId': transactionId});

      // You may want to perform additional actions if needed
    } catch (e) {
      print('Error adding transaction to user: $e');
      throw e;
    }
  }

  Stream<List<TransactionsMain>> getUserTransactions() {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final userId = user.uid;
        final userDocRef = usersCollection.doc(userId);

        // You can place any logic here, for example:
        // print('UserId: $userId');

        return userDocRef
            .collection('parties') // Adjust the collection name accordingly
            .snapshots()
            .asyncMap((partySnapshot) async {
          List<TransactionsMain> allTransactions = [];

          for (var partyDoc in partySnapshot.docs) {
            var partyId = partyDoc.id;

            var partyTransactions = await userDocRef
                .collection('parties')
                .doc(partyId)
                .collection('transactions')
                .where('sender', isEqualTo: userId)
                .get();

            allTransactions.addAll(partyTransactions.docs.map((doc) {
              final data = doc.data() as Map<String, dynamic>;
              return TransactionsMain(
                amount: data['amount'],
                description: data['description'],
                sender: data['sender'],
                timestamp: data['timestamp'],
                reciever: data['receiver'],
                balance: data['balance'],
                isEditable: data['isEditable'],
                recieverName: data['receiverName'],
                recieverId: data['receiverId'],
                transactionType: data['transactionType'],
                transactionId: data['transactionId'],
                senderName: data['senderName'],
              );
            }));
          }

          return allTransactions;
        });
      } else {
        // Handle the case where the user is not authenticated
        throw Exception("User not authenticated");
      }
    } catch (e) {
      print('Error getting user transactions: $e');
      // You might want to handle errors differently (throw, return empty list, etc.)
      throw e;
    }
  }

  Future<void> deleteParty(String userId, String partyId) async {
    try {
      final userDocRef =
          FirebaseFirestore.instance.collection('users').doc(userId);
      final partyDocRef = userDocRef.collection('parties').doc(partyId);

      // Get the list of transaction IDs for the party
      final partySnapshot = await partyDocRef.collection('transactions').get();
      final transactionIds = partySnapshot.docs.map((doc) => doc.id).toList();

      // Delete each transaction
      for (String transactionId in transactionIds) {
        await deleteTransaction(userId, partyId, transactionId);
      }

      // Finally, delete the party
      await partyDocRef.delete();
    } catch (e) {
      print('Error deleting party: $e');
      throw e;
    }
  }

  Future<void> deleteTransaction(
      String userId, String partyId, String transactionId) async {
    try {
      final userDocRef =
          FirebaseFirestore.instance.collection('users').doc(userId);
      final transactionDocRef = userDocRef
          .collection('parties')
          .doc(partyId)
          .collection('transactions')
          .doc(transactionId);
      await transactionDocRef.delete();
      print('Transaction ID: - ' + transactionId);
    } catch (e) {
      print('Error deleting transaction: $e');
      throw e;
    }
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

  Future<void> addSale(
      String partyId, double saleAmount, String userId, String userName) async {
    try {
      final userDocRef = usersCollection.doc(userId);
      final partyDocRef = userDocRef.collection('parties').doc(partyId);

      // Get the current party data
      final partyDoc = await partyDocRef.get();
      final partyData = partyDoc.data() as Map<String, dynamic>;

      // Calculate the new balance after the sale
      double currentBalance = partyData['balance'] ?? 0.0;
      double newBalance = currentBalance - saleAmount;

      // Update the party's balance
      await partyDocRef.update({'balance': newBalance});

      // Add a transaction for the sale
      await MainPartyController().addTransactionToParty(
        partyId,
        TransactionsMain(
          amount: saleAmount,
          description: 'pay', // Add Dynamic Description
          timestamp: Timestamp.now(),
          reciever: partyData['name'], // Assuming this is the party's name
          sender: userId,
          balance: 0,
          isEditable: true,
          recieverName: partyData['name'], // Assuming this is the party's name
          recieverId: partyId,
          transactionType: 'pay',
          transactionId: '', // You may want to generate a unique ID here
          senderName: userName, // You may want to set the sender's name here
        ),
        userId,
      );
    } catch (e) {
      print('Error adding sale: $e');
      throw e;
    }
  }

  Future<void> addPayment(
      String partyId, double paymentAmount, String userId) async {
    try {
      final userDocRef = usersCollection.doc(userId);
      final partyDocRef = userDocRef.collection('parties').doc(partyId);

      // Get the current party data
      final partyDoc = await partyDocRef.get();
      final partyData = partyDoc.data() as Map<String, dynamic>;

      // Calculate the new balance after adding the payment
      double currentBalance = partyData['balance'] ?? 0.0;
      double newBalance = currentBalance + paymentAmount;

      // Update the party's balance
      await partyDocRef.update({'balance': newBalance});
    } catch (e) {
      print('Error adding payment: $e');
      throw e;
    }
  }
}

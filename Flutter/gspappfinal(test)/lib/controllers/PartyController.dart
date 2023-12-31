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
      await userDocRef.collection('transactions').add({
        ...transactionMain.toMap(),
        'transactionId': transactionId,
      });
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
        print('UserId: $userId');

        return userDocRef
            .collection('transactions')
            .snapshots()
            .map((snapshot) {
          return snapshot.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            // Assuming you have a TransactionModel class
            return TransactionsMain(
                // Map the fields accordingly based on your model
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
                transactionId: data['transactionId']

                // Add other fields as needed
                );
          }).toList();
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

  Future<void> deleteTransactionFromUser(
      String userId, String transactionId) async {
    try {
      final userDocRef = usersCollection.doc(userId);

      // Delete the transaction from the user's transactions collection
      await userDocRef.collection('transactions').doc(transactionId).delete();
    } catch (e) {
      print('Error deleting transaction from user: $e');
      throw e;
    }
  }

  Future<List<String>> getPartyTransactions(
      String userId, String partyId) async {
    try {
      final userDocRef =
          FirebaseFirestore.instance.collection('users').doc(userId);

      // Get the party document
      final partyDocSnapshot =
          await userDocRef.collection('parties').doc(partyId).get();

      // Check if the party document exists
      if (partyDocSnapshot.exists) {
        // Extract transaction IDs from the party document
        final partyData = partyDocSnapshot.data() as Map<String, dynamic>;
        final List<String> partyTransactions =
            List<String>.from(partyData['transactions'] ?? []);

        // Get the user's transactions
        final userTransactionsQuery = await userDocRef
            .collection('transactions')
            .where('receiverId', isEqualTo: partyId)
            .get();
        final List<String> userTransactions =
            userTransactionsQuery.docs.map((doc) => doc.id).toList();

        // Combine and return the transaction IDs from both party and user transactions
        return [...partyTransactions, ...userTransactions];
      } else {
        // Party document does not exist
        return [];
      }
    } catch (e) {
      print('Error getting party transactions: $e');
      throw e;
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gspappfinal/controllers/PartyController.dart';
import 'package:gspappfinal/models/PartyModel.dart';
import 'package:gspappfinal/views/AddSalesPage.dart'; // Replace with the actual path to your Party model
import 'package:intl/intl.dart';

class PartyDetailsPage extends StatefulWidget {
  final String partyId;

  PartyDetailsPage({required this.partyId});

  @override
  State<PartyDetailsPage> createState() => _PartyDetailsPageState();
}

class _PartyDetailsPageState extends State<PartyDetailsPage> {
  final MainPartyController partyController = MainPartyController();
  String? getCurrentUserUid() {
    final User? user = FirebaseAuth.instance.currentUser;
    return user?.uid;
  }

  @override
  Widget build(BuildContext context) {
    final String? userId = getCurrentUserUid();
    return Scaffold(
      appBar: AppBar(
        title: Text('Party Details'),
      ),
      body: StreamBuilder<List<Party>>(
        stream: partyController.partiesStream(userId!), // Stream of parties
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final parties = snapshot.data ?? [];
            final party = parties.firstWhere(
              (p) => p.id == widget.partyId,
              orElse: () => Party(
                id: '',
                name: 'Party Name',
                contactNumber: 'Contact Number',
                balance: 0.0,
                transactions: [],
                BillingAddress: '',
                EmailAddress: '',
                GSTID: '',
                paymentType: '',
                balanceType: '',
                creationDate: DateTime.now() as String,
              ),
            );

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name: ${party.name}',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        'Contact: ${party.contactNumber}',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        'Balance: Rs. ${party.balance.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                Divider(),
                Text(
                  'Transactions:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(
                            userId) // Use the user's ID to reference their document
                        .collection('parties')
                        .doc(widget
                            .partyId) // Use the party ID to reference the specific party document
                        .collection('transactions')
                        .snapshots(),
                    builder: (context, transactionSnapshot) {
                      if (transactionSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (transactionSnapshot.hasError) {
                        return Text('Error: ${transactionSnapshot.error}');
                      } else {
                        final transactionDocs = transactionSnapshot.data!.docs;
                        return ListView.builder(
                          itemCount: transactionDocs.length,
                          itemBuilder: (context, index) {
                            final transactionData = transactionDocs[index]
                                .data() as Map<String, dynamic>;
                            final amount = transactionData['amount'];
                            final timestamp = transactionData['timestamp'];

                            final formattedDate =
                                (timestamp as Timestamp).toDate();
                            final formattedDateString = DateFormat.yMMMMd()
                                .add_jm()
                                .format(formattedDate);

                            return ListTile(
                              title: Text('Rs. $amount'),
                              subtitle: Text(formattedDateString),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AddSalePage(
                            partyId: party.id, currentBalance: party.balance)));
                  },
                  child: Text('Sale'),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

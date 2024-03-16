import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gspappfinal/components/transactionCard.dart';
import 'package:gspappfinal/constants/AppColor.dart';
import 'package:gspappfinal/controllers/PartyController.dart';
import 'package:gspappfinal/models/PartyModel.dart';
import 'package:gspappfinal/views/transaction_functions/add_sale_page.dart';

class PartyDetailsPage extends StatefulWidget {
  final String partyId;
  final String partyName;
  final String PgstId;

  PartyDetailsPage({
    required this.partyId,
    required this.partyName,
    required this.PgstId,
  });

  @override
  State<PartyDetailsPage> createState() => _PartyDetailsPageState();
}

class _PartyDetailsPageState extends State<PartyDetailsPage> {
  final MainPartyController partyController = MainPartyController();
  String? getCurrentUserUid() {
    final User? user = FirebaseAuth.instance.currentUser;
    return user?.uid;
  }

  String userName = ''; // A variable to store the user name

  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  void fetchFirstName() async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final userId = user.uid;

        // Fetch user details from Firestore
        final userData = await usersCollection.doc(userId).get();
        final userDataMap = userData.data() as Map<String, dynamic>?;

        if (userDataMap != null && userDataMap.containsKey('first_name')) {
          final firstName = userDataMap['first_name'] as String;
          final email = userDataMap['email'] as String;

          setState(() {
            userName = firstName;
          });
        }
      }
    } catch (e) {
      // Handle any errors here
      // print('Error fetching first name: $e');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchFirstName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String? userId = getCurrentUserUid();
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: AppBar(
        title: Text(
          'Party Details',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: AppColors.secondaryColor,
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
                creationDate: Timestamp.fromDate(
                  DateTime.now(),
                ),
                GSTType: '',
                POS: '',
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
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Contact: ${party.contactNumber}',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Balance: Rs. ${party.balance.toStringAsFixed(2)}',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
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
                            final balance = transactionData['balance'];
                            final sender = transactionData['senderName'];
                            final receiver = transactionData['receiver'];
                            final transactionID =
                                transactionData['transactionId'];
                            final transactionType =
                                transactionData['transactionType'];
                            final _isEditable = transactionData['isEditable'];
                            return transactionCard(
                              amount: amount,
                              balance: balance,
                              name: sender,
                              transactionType: transactionType,
                              transactionId: transactionID,
                              partyId: receiver,
                              userId: sender,
                              isEditable: _isEditable,
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => AddSalePage(
                              userName: userName,
                              partyId: widget.partyId,
                              userId: userId,
                              partyName: widget.partyName,
                              PgstId: widget.PgstId,
                            ),
                          ),
                        );
                      },
                      child: const Text('Sale'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => AddSalePage(
                              userName: userName,
                              userId: widget.partyId,
                              partyId: userId,
                              partyName: widget.partyName,
                              PgstId: widget.PgstId,
                            ),
                          ),
                        );
                      },
                      child: const Text('Purchase'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 22,
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

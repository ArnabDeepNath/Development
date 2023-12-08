import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gspappfinal/constants/AppColor.dart';
import 'package:gspappfinal/constants/AppTheme.dart';
import 'package:gspappfinal/views/AddItemsPage.dart';

class itemsDisplayPage extends StatefulWidget {
  const itemsDisplayPage({super.key});

  @override
  State<itemsDisplayPage> createState() => _itemsDisplayPageState();
}

class _itemsDisplayPageState extends State<itemsDisplayPage> {
  @override
  late Stream<QuerySnapshot> itemsStream;

  @override
  void initState() {
    super.initState();

    // Get the current user ID
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userId = user.uid;

      // Reference to the user's items subcollection
      final CollectionReference itemsCollection = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('items');

      // Set up the stream to listen for changes in the items subcollection
      itemsStream = itemsCollection.snapshots();
    }
  }

  void _deleteItem(String itemId) {
    try {
      // Get the current user ID
      final User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final userId = user.uid;

        // Reference to the user's items subcollection
        final CollectionReference itemsCollection = FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('items');

        // Delete the item
        itemsCollection.doc(itemId).delete();
      }
    } catch (e) {
      print('Error deleting item: $e');
      // Handle errors (show an error message, log, etc.)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Your Items',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: itemsStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                // Check if there are no items
                if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No items available.'));
                }

                // Display the list of items
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Adjust the crossAxisCount as needed
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                    ),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var item = snapshot.data!.docs[index].data()
                          as Map<String, dynamic>;
                      // Customize the item display as needed
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              offset: const Offset(0, 2),
                              blurRadius: 4,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            children: [
                              ListTile(
                                subtitle: Center(
                                  child: Text(
                                    item['itemName'],
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                title: CircleAvatar(
                                  radius: 40,
                                  backgroundImage: NetworkImage(
                                    item['itemImage'],
                                  ),
                                ),
                                // trailing: Text(
                                //   'Unit: ' + item['itemUnit'],
                                //   style: GoogleFonts.inter(
                                //     fontWeight: FontWeight.w600,
                                //     fontSize: 14,
                                //   ),
                                // ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    onTap: () {},
                                    child: Column(
                                      children: [
                                        const Icon(
                                          Icons.edit,
                                          color: AppColors.primaryColor,
                                        ),
                                        Text(
                                          'Edit Item',
                                          style: AppFonts.Subtitle2(),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const VerticalDivider(
                                    color: Colors.grey,
                                    thickness: 0.8,
                                    indent: 5,
                                    endIndent: 5,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      _deleteItem(
                                          snapshot.data!.docs[index].id);
                                    },
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.cancel,
                                          color: Colors.redAccent,
                                        ),
                                        Text(
                                          'Delete Item',
                                          style: AppFonts.Subtitle2(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddItemsPage(),
                  ),
                );
              },
              child: Container(
                height: 44,
                width: MediaQuery.of(context).size.width * 0.6,
                child: Center(
                  child: Text(
                    'Add Item',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

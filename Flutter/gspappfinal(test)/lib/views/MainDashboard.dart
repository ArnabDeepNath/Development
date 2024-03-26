import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gspappfinal/components/drawerComponent.dart';
import 'package:gspappfinal/constants/AppColor.dart';
import 'package:gspappfinal/constants/AppTheme.dart';
import 'package:gspappfinal/auth/LoginPage.dart';
import 'package:gspappfinal/views/AltHomePage.dart';
import 'package:gspappfinal/views/party_functions/add_party_page.dart';
import 'package:gspappfinal/views/items_functions/EmptyItemsPage.dart';
import 'package:gspappfinal/views/HomePage.dart';
import 'package:gspappfinal/views/items_functions/ItemsDisplayPage.dart';
import 'package:gspappfinal/views/report_functions/report_fucntion_1.dart';
import 'package:gspappfinal/views/transaction_functions/TransactionsPage.dart';

class MainDashboard extends StatefulWidget {
  final String userID;
  const MainDashboard({super.key, required this.userID});

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  int _selectedIndex = 0;

  late List<Widget> _pages; // Declare _pages as late
  String userName = ''; // A variable to store the user name
  String userEmail = '';
  String userIdPage = '';
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
            userEmail = email;
            userIdPage = user.uid;
          });
        }
      }
    } catch (e) {
      // Handle any errors here
      // print('Error fetching first name: $e');
    }
  }

  void signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      // You can navigate to the login page or any other desired screen after sign-out.
      // For example, you can navigate to a login page as shown below.
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) =>
              LoginPage(), // Replace with your login page widget
        ),
      );
    } catch (e) {
      // print('Error signing out: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    initializePage();
  }

  Future<void> initializePage() async {
    fetchFirstName();
    setState(() {
      _pages = [
        const HomePage(),
        _buildItemsPage(),
        UserTransactionsPage(),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              const CircleAvatar(
                radius: 45,
                backgroundImage: NetworkImage(
                    'https://pbs.twimg.com/profile_images/1543295063920238592/vvjaWA5W_400x400.jpg'),
              ),
              Text(
                '$userEmail',
                style: AppFonts.Subtitle2(),
              ),
              const Divider(
                thickness: 0.8,
                endIndent: 20,
                indent: 10,
              ),
              drawerComponent(
                name: 'Home',
                icon: Icons.home,
                onChanged: () {},
              ),
              drawerComponent(
                name: 'Transactions',
                icon: Icons.compare_arrows,
                onChanged: () {},
              ),
              drawerComponent(
                name: 'Reports',
                icon: Icons.note,
                onChanged: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReportFunction(),
                    ),
                  );
                },
              ),
              drawerComponent(
                name: 'Items',
                icon: Icons.shopping_bag,
                onChanged: () {},
              ),
              drawerComponent(
                name: 'Settings',
                icon: Icons.settings,
                onChanged: () {},
              ),
              drawerComponent(
                name: 'Parties',
                icon: Icons.person_search,
                onChanged: () {},
              ),
              drawerComponent(
                name: 'About Us',
                icon: Icons.info,
                onChanged: () {},
              ),
              drawerComponent(
                name: 'Sign out',
                icon: Icons.logout,
                onChanged: () {
                  signOut();
                },
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        title: Text(
          'Hello $userName',
          style: AppFonts.Header1(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              child: const Text(
                'Add Party',
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AddPartyScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.secondaryColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildCustomButton('Dashboard', 0),
                  buildCustomButton('Items', 1),
                  buildCustomButton('Transactions', 2),
                  // Add more buttons as needed
                ],
              ),
            ),
          ),
          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: _pages,
            ),
          )
        ],
      ),
    );
  }

  Widget buildCustomButton(String text, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: _selectedIndex == index
                ? AppColors.primaryColor
                : Colors.black.withOpacity(0.2),
          ),
          color: _selectedIndex == index
              ? AppColors.primaryColor.withOpacity(0.1)
              : Colors.transparent,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: _selectedIndex == index
                ? AppColors.primaryColor
                : Colors.black.withOpacity(0.2),
          ),
        ),
      ),
    );
  }
}

Stream<bool> userHasItemsStream() async* {
  try {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final userId = user.uid;

      // Reference to the user's document in the "users" collection
      final userDocRef =
          FirebaseFirestore.instance.collection('users').doc(userId);

      // Check if the "items" subcollection exists
      final itemsCollection = userDocRef.collection('items');

      // Use snapshots() to listen for changes in the items subcollection
      await for (QuerySnapshot itemsSnapshot in itemsCollection.snapshots()) {
        // Yield true if the subcollection exists and is empty
        yield !itemsSnapshot.docs.isEmpty;
      }
    }

    // Yield false if user not found
    yield false;
  } catch (e) {
    print('Error checking if user has items: $e');
    // Yield false in case of an error
    yield false;
  }
}

Widget _buildItemsPage() {
  return StreamBuilder<bool>(
    stream: userHasItemsStream(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        // If the stream is still waiting for data, show a loading indicator
        return CircularProgressIndicator();
      } else if (snapshot.hasError) {
        // If there's an error, display an error message
        return Text('Error checking items: ${snapshot.error}');
      } else {
        // If the stream is completed, determine whether to show ItemsPage or AddItemsPage
        bool hasItems = snapshot.data ?? false;
        return hasItems ? itemsDisplayPage() : emptyItemsPage();
      }
    },
  );
}

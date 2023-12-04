import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gspappfinal/components/SlideButton.dart';
import 'package:gspappfinal/components/TextFormField.dart';
import 'package:gspappfinal/constants/AppColor.dart';
import 'package:gspappfinal/controllers/PartyController.dart';
import 'package:gspappfinal/models/PartyModel.dart';
import 'package:intl/intl.dart';

class AddPartyScreen extends StatefulWidget {
  AddPartyScreen({Key? key});

  @override
  State<AddPartyScreen> createState() => _AddPartyScreenState();
}

class _AddPartyScreenState extends State<AddPartyScreen>
    with TickerProviderStateMixin {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController PartyNameController = TextEditingController();
  TextEditingController PartyBalanceController = TextEditingController();
  TextEditingController PartyContactController = TextEditingController();
  TextEditingController PartyGSTController = TextEditingController();
  TextEditingController PartyCreationController = TextEditingController();
  TextEditingController PartyBillingAddress = TextEditingController();
  TextEditingController PartyEmailAddress = TextEditingController();
  late String paymentType;
  late String BalanceType;
  final MainPartyController PartyController = MainPartyController();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        // Update the date in the partyCreation TextEditingController
        PartyCreationController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  String? getCurrentUserUid() {
    final User? user = FirebaseAuth.instance.currentUser;
    return user?.uid;
  }

  // Define a controller for the TabBar
  late TabController _tabController;
  bool userTyping = false; // Added variable to track user typing

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  void clear() {
    PartyBalanceController.clear();
    PartyContactController.clear();
    PartyNameController.clear();
  }

  Future<void> createNewParty() async {
    try {
      String? userId = getCurrentUserUid();

      if (userId != null) {
        double balance = double.tryParse(PartyBalanceController.text) ?? 0.0;

        // If the payment type is 'pay', add a negative sign to the balance
        if (paymentType == 'pay') {
          balance = -balance;
        }

        final Party newParty = Party(
          id: '',
          name: PartyNameController.text,
          contactNumber: PartyContactController.text,
          balance: balance,
          GSTID: PartyGSTController.text,
          BillingAddress: PartyBillingAddress.text,
          EmailAddress: PartyEmailAddress.text,
          paymentType: paymentType,
          balanceType: 'BalanceType',
          creationDate: '',
          transactions: [],
        );

        // Pass the user's UID to the addParty function
        await PartyController.addParty(newParty, userId);

        print('New party added successfully');
      } else {
        print('User is not logged in.');
      }
    } catch (e) {
      print('Error creating a new party: $e');
    }
  }

  String? nonEmptyValidator(String? value) {
    if (value != null && value.isNotEmpty) {
      return null; // Field is not empty, so it's valid.
    }

    // Field is empty, so return an error message.
    return 'This field cannot be empty';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          'Add Party',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          SlideButton(
            choice1: 'Cheque',
            choice2: 'Cash',
            onSelectionChanged: (selected) {
              print('Selected: $selected');
            },
            Colors: Colors.green,
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormFieldCustom(
                validator: nonEmptyValidator,
                label: 'Party Name',
                controller: PartyNameController,
                obscureText: false,
                onChange: (text) {
                  // Set userTyping to true when the user starts typing
                  setState(() {
                    userTyping = true;
                  });
                  if (_tabController.indexIsChanging) {
                    _tabController.animateTo(0);
                  }
                },
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3), // Shadow color
                            // Shadow color
                            offset: const Offset(0, 2), // Offset of the shadow
                            blurRadius: 4, // Blur radius of the shadow
                            spreadRadius: 1, // Spread radius of the shadow
                          ),
                        ],
                      ),
                      width: 155,
                      child: TextFormField(
                        onChanged: (text) {
                          // Set userTyping to true when the user starts typing
                          setState(() {
                            userTyping = true;
                          });
                          if (_tabController.indexIsChanging) {
                            _tabController.animateTo(0);
                          }
                        },
                        controller: PartyBalanceController,
                        decoration: InputDecoration(
                          labelText: 'Opening Balance*',
                          labelStyle: GoogleFonts.inter(
                            color: AppColors.primaryColor,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.primaryColor,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3), // Shadow color
                            // Shadow color
                            offset: const Offset(0, 2), // Offset of the shadow
                            blurRadius: 4, // Blur radius of the shadow
                            spreadRadius: 1, // Spread radius of the shadow
                          ),
                        ],
                      ),
                      width: 155,
                      child: TextFormField(
                        controller: PartyCreationController,
                        onTap: () {
                          // Show date picker when the user taps on the TextFormField
                          _selectDate(context);
                        },
                        decoration: InputDecoration(
                          labelText: 'As of Date*',
                          labelStyle: GoogleFonts.inter(
                            color: AppColors.primaryColor,
                          ),
                          // Set the border color here
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SlideButton(
                choice1: 'To Pay',
                choice2: 'To Recieve',
                onSelectionChanged: (selected) {
                  if (selected == 'To Pay') {
                    setState(
                      () {
                        paymentType = 'pay';
                      },
                    );
                  } else if (selected == 'To Recieve') {
                    setState(() {
                      paymentType = 'receieve';
                    });
                  }
                  print(paymentType);
                },
                Colors: Colors.red,
              ),
              TextFormFieldCustom(
                validator: nonEmptyValidator,
                label: 'Contact Number',
                controller: PartyContactController,
                obscureText: false,
                onChange: (text) {
                  // Set userTyping to true when the user starts typing
                  setState(() {
                    userTyping = true;
                  });
                  if (_tabController.indexIsChanging) {
                    _tabController.animateTo(0);
                  }
                },
              ),
              // Add a placeholder for the TabBar and TabBarView
              Visibility(
                visible: userTyping,
                child: Column(
                  children: [
                    TabBar(
                      controller: _tabController,
                      tabs: [
                        Tab(text: 'Address'),
                        Tab(text: 'GST Details'),
                      ],
                    ),
                    Container(
                      height: 200, // Set the desired height
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          // Add widgets for the first tab here
                          Column(
                            children: [
                              TextFormFieldCustom(
                                validator: nonEmptyValidator,
                                label: 'Billing Address',
                                controller: PartyGSTController,
                                obscureText: false,
                                onChange: (text) {
                                  // Set userTyping to true when the user starts typing
                                },
                              ),
                              TextFormFieldCustom(
                                validator: nonEmptyValidator,
                                obscureText: false,
                                label: 'Email Address',
                                controller: PartyGSTController,
                                onChange: (text) {
                                  // Set userTyping to true when the user starts typing
                                },
                              ),
                            ],
                          ),
                          // Add widgets for the second tab here
                          Column(
                            children: [
                              TextFormFieldCustom(
                                validator: nonEmptyValidator,
                                obscureText: false,
                                label: 'GST Type',
                                controller: PartyGSTController,
                                onChange: (text) {
                                  // Set userTyping to true when the user starts typing
                                },
                              ),
                              TextFormFieldCustom(
                                validator: nonEmptyValidator,
                                obscureText: false,
                                label: 'State',
                                controller: PartyGSTController,
                                onChange: (text) {
                                  // Set userTyping to true when the user starts typing
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 22),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // The form is valid, proceed to create a new party.
                    createNewParty();
                    clear();
                  }
                },
                child: Text('Add New Party'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

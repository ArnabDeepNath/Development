import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gspappfinal/components/BalanceWidget.dart';
import 'package:gspappfinal/constants/AppColor.dart';
import 'package:gspappfinal/constants/AppTheme.dart';
import 'package:gspappfinal/controllers/PartyController.dart';
import 'package:gspappfinal/models/PartyModel.dart';
import 'package:gspappfinal/utils/BalanceProvider.dart';
import 'package:gspappfinal/views/party_functions/PartyView.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:gspappfinal/utils/calcFuncs.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CalcUtil _calcUtil = CalcUtil();
  final MainPartyController partyController = MainPartyController();

  String? getCurrentUserUid() {
    final User? user = FirebaseAuth.instance.currentUser;
    return user?.uid;
  }

  @override
  void initState() {
    super.initState();
    // FirebaseAuth.instance.authStateChanges().listen((user) {
    //   if (user != null) {
    //     final String userId = user.uid;
    //     _calcUtil.calculateTotalPayAmount(userId);
    //     _calcUtil.calculateTotalRecievedAmount(userId);
    //     Provider.of<BalanceProvider>(context, listen: false)
    //         .listenToBalanceChanges(userId);
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    final String? userId = getCurrentUserUid();
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.08,
                  width: MediaQuery.of(context).size.width * 0.4,
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
                  child: StreamBuilder<double>(
                    stream: Provider.of<BalanceProvider>(context)
                        .getTotalBalanceStream(userId!),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return Text('Total Balance: Rs. ${snapshot.data}');
                      }
                    },
                  ),
                ),
                // InkWell(
                //   onTap: () {},
                //   child: Container(
                //     height: MediaQuery.of(context).size.height * 0.08,
                //     width: MediaQuery.of(context).size.width * 0.4,
                //     decoration: BoxDecoration(
                //       color: Colors.white,
                //       borderRadius: BorderRadius.circular(10),
                //       boxShadow: [
                //         BoxShadow(
                //           color: Colors.grey.withOpacity(0.3),
                //           offset: const Offset(0, 2),
                //           blurRadius: 4,
                //           spreadRadius: 1,
                //         ),
                //       ],
                //     ),
                //     child: Center(
                //       child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.center,
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           Text(
                //             'Total Expense',
                //             style: AppFonts.SubtitleColor(),
                //           ),
                //           StreamBuilder<Map<String, dynamic>>(
                //             stream: _calcUtil.totalReceivedAmountStream,
                //             builder: (context, snapshot) {
                //               if (snapshot.connectionState ==
                //                   ConnectionState.waiting) {
                //                 return CircularProgressIndicator();
                //               } else if (snapshot.hasError) {
                //                 return Text('Error: ${snapshot.error}');
                //               } else {
                //                 double totalReceivedAmount =
                //                     snapshot.data?['totalAmount'];
                //                 return Text(
                //                   'Rs. $totalReceivedAmount',
                //                   style: AppFonts.Subtitle2(),
                //                 );
                //               }
                //             },
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                // InkWell(
                //   onTap: () {},
                //   child: Container(
                //     height: MediaQuery.of(context).size.height * 0.08,
                //     width: MediaQuery.of(context).size.width * 0.4,
                //     decoration: BoxDecoration(
                //       color: Colors.white,
                //       borderRadius: BorderRadius.circular(10),
                //       boxShadow: [
                //         BoxShadow(
                //           color: Colors.grey.withOpacity(0.3),
                //           offset: const Offset(0, 2),
                //           blurRadius: 4,
                //           spreadRadius: 1,
                //         ),
                //       ],
                //     ),
                //     child: Center(
                //       child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.center,
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           Text(
                //             'Total Income',
                //             style: AppFonts.SubtitleColor(),
                //           ),
                //           StreamBuilder<Map<String, dynamic>>(
                //             stream: _calcUtil.totalPayAmountStream,
                //             builder: (context, snapshot) {
                //               if (snapshot.connectionState ==
                //                   ConnectionState.waiting) {
                //                 return CircularProgressIndicator();
                //               } else if (snapshot.hasError) {
                //                 return Text('Error: ${snapshot.error}');
                //               } else {
                //                 double totalReceivedAmount =
                //                     snapshot.data?['totalPayAmount'] ?? 0.0;
                //                 return Text(
                //                   'Rs. $totalReceivedAmount',
                //                   style: AppFonts.Subtitle2(),
                //                 );
                //               }
                //             },
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          // Carousel Section for Ads and Banners
          // Padding(
          //   padding: const EdgeInsets.all(16.0),
          //   child: Container(
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(10),
          //     ),
          //     child: CarouselSlider(
          //       items: const [
          //         Image(
          //           image: NetworkImage(
          //               'https://www.startupguruz.com/wp-content/uploads/2022/05/online-gst-registration-banner1.png'),
          //         ),
          //         Image(
          //           image: NetworkImage(
          //               'https://www.startupguruz.com/wp-content/uploads/2023/04/every-information-of-gst-reg-18-form.png'),
          //         ),
          //         Image(
          //           image: NetworkImage(
          //               'https://www.startupguruz.com/wp-content/uploads/2022/05/GST-Registration-ads.png'),
          //         )
          //       ],
          //       options: CarouselOptions(
          //         autoPlay: true,
          //         autoPlayInterval: const Duration(seconds: 4),
          //         enlargeCenterPage: true,
          //       ),
          //     ),
          //   ),
          // ),

          // Parties Display Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Your Parties',
              style: AppFonts.Header1(),
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Party>>(
              stream: partyController.partiesStream(userId!),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.data!.isEmpty) {
                  return Center(
                    child: Text(
                      'No parties found.',
                      style: GoogleFonts.inter(
                        fontSize: 22,
                      ),
                    ),
                  );
                } else {
                  final parties = snapshot.data!;
                  return ListView.builder(
                    itemCount: parties.length,
                    itemBuilder: (context, index) {
                      final party = parties[index];
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.18,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey
                                    .withOpacity(0.3), // Shadow color
                                // Shadow color
                                offset:
                                    const Offset(0, 2), // Offset of the shadow
                                blurRadius: 4, // Blur radius of the shadow
                                spreadRadius: 1, // Spread radius of the shadow
                              ),
                            ],
                            // border: Border.all(
                            //   color: AppColors().primaryColor,
                            // ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ListTile(
                                title: Text(
                                  party.name,
                                  style: AppFonts.Subtitle(),
                                ),
                                subtitle: Text(
                                  party.contactNumber,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                trailing: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Rs. ${party.balance}',
                                      style: GoogleFonts.inter(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: party.balanceType == 'recieve'
                                            ? Colors.red
                                            : Colors.green,
                                      ),
                                    ),
                                    Text(
                                      party.balanceType == 'recieve'
                                          ? 'You will pay'
                                          : 'You will receive',
                                      style: GoogleFonts.inter(
                                        color: party.balanceType == 'recieve'
                                            ? Colors.red
                                            : Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => PartyDetailsPage(
                                        userName: userId,
                                        partyId: party.id,
                                        partyName: party.name,
                                        PgstId: party.GSTID,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: IntrinsicHeight(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        child: Column(
                                          children: [
                                            Icon(
                                              Icons.call,
                                            ),
                                            Text(
                                              'Send Notfication',
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
                                        onTap: () async {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: Text('Confirm Deletion'),
                                                content: Text(
                                                    'Are you sure you want to delete this party?'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop(); // Close the dialog
                                                    },
                                                    child: Text('Cancel'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () async {
                                                      // Finally, delete the party
                                                      await partyController
                                                          .deleteParty(
                                                              userId, party.id);

                                                      // Close the dialog
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text('Delete'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        child: Column(
                                          children: [
                                            Icon(
                                              Icons.cancel,
                                            ),
                                            Text(
                                              'Delete Party',
                                              style: AppFonts.Subtitle2(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

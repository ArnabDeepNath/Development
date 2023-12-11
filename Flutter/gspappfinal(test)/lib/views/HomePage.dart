import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gspappfinal/constants/AppColor.dart';
import 'package:gspappfinal/constants/AppTheme.dart';
import 'package:gspappfinal/controllers/PartyController.dart';
import 'package:gspappfinal/models/PartyModel.dart';
import 'package:gspappfinal/utils/PartyView.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final MainPartyController partyController = MainPartyController();
  String? getCurrentUserUid() {
    final User? user = FirebaseAuth.instance.currentUser;
    return user?.uid;
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
                InkWell(
                  onTap: () {},
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: MediaQuery.of(context).size.width * 0.4,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3), // Shadow color
                          // Shadow color
                          offset: const Offset(0, 2), // Offset of the shadow
                          blurRadius: 4, // Blur radius of the shadow
                          spreadRadius: 1, // Spread radius of the shadow
                        ),
                      ],
                      // border: Border.all(
                      //   color: AppColors().,
                      // ),
                    ),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Total Expense',
                            style: AppFonts.SubtitleColor(),
                          ),
                          Text(
                            'Rs. 5000',
                            style: AppFonts.Subtitle2(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: MediaQuery.of(context).size.width * 0.4,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3), // Shadow color
                          offset: const Offset(0, 2), // Offset of the shadow
                          blurRadius: 4, // Blur radius of the shadow
                          spreadRadius: 1, // Spread radius of the shadow
                        ),
                      ],
                    ),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Total Income',
                            style: AppFonts.SubtitleColor(),
                          ),
                          Text(
                            'Rs. 15000',
                            style: AppFonts.Subtitle2(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Carousel Section for Ads and Banners
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: CarouselSlider(
                items: const [
                  Image(
                    image: NetworkImage(
                        'https://www.startupguruz.com/wp-content/uploads/2022/05/online-gst-registration-banner1.png'),
                  ),
                  Image(
                    image: NetworkImage(
                        'https://www.startupguruz.com/wp-content/uploads/2023/04/every-information-of-gst-reg-18-form.png'),
                  ),
                  Image(
                    image: NetworkImage(
                        'https://www.startupguruz.com/wp-content/uploads/2022/05/GST-Registration-ads.png'),
                  )
                ],
                options: CarouselOptions(
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 4),
                  enlargeCenterPage: true,
                ),
              ),
            ),
          ),

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
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.data!.isEmpty) {
                  return const Text('No parties found.');
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
                                          ? 'You will receive'
                                          : 'You will pay',
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
                                        partyId: party.id,
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
                                        onTap: () {},
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

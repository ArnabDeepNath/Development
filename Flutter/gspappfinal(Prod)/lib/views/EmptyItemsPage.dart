import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gspappfinal/constants/AppColor.dart';
import 'package:gspappfinal/views/AddItemsPage.dart';
import 'package:lottie/lottie.dart';

class emptyItemsPage extends StatefulWidget {
  const emptyItemsPage({super.key});

  @override
  State<emptyItemsPage> createState() => _emptyItemsPageState();
}

class _emptyItemsPageState extends State<emptyItemsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Lottie.network(
              'https://lottie.host/b4706807-78ca-44b2-96a6-28d7b285842f/a55GfEZT50.json'),
          Center(
            child: Text(
              "You don't have any items , please add to view.",
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                color: Colors.black54,
              ),
            ),
          ),
          InkWell(
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
                  'Add Party',
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
          )
        ],
      ),
    );
  }
}

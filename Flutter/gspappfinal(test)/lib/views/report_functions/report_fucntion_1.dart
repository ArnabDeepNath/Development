import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gspappfinal/constants/AppColor.dart';
import 'package:gspappfinal/constants/AppTheme.dart';

class ReportFunction extends StatefulWidget {
  const ReportFunction({super.key});

  @override
  State<ReportFunction> createState() => _ReportFunctionState();
}

class _ReportFunctionState extends State<ReportFunction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        title: Text(
          'Reports',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      backgroundColor: AppColors.secondaryColor,
    );
  }
}

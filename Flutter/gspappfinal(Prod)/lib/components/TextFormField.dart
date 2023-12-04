import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gspappfinal/constants/AppColor.dart';

// ignore: must_be_immutable
class TextFormFieldCustom extends StatefulWidget {
  String label;
  TextEditingController controller;
  Function(String)? onChange;
  String? Function(String?)? validator;
  bool obscureText;

  TextFormFieldCustom({
    super.key,
    required this.label,
    required this.controller,
    required this.onChange,
    required this.validator,
    required this.obscureText,
  });

  @override
  State<TextFormFieldCustom> createState() => _TextFormFieldCustomState();
}

class _TextFormFieldCustomState extends State<TextFormFieldCustom> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 54,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
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
        child: TextFormField(
          style: GoogleFonts.inter(
            color: Colors.black,
          ),
          validator: widget.validator,
          controller: widget.controller,
          obscureText: widget.obscureText,
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Icon(
              Icons.person,
              color: AppColors.primaryColor,
            ),
            labelText: widget.label,
            labelStyle: GoogleFonts.inter(
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
          onChanged: widget.onChange, // Use the provided onChanged callback
        ),
      ),
    );
  }
}

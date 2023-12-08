import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gspappfinal/constants/AppColor.dart';

class SlideButton extends StatefulWidget {
  final ValueChanged<String> onSelectionChanged;
  final String choice1;
  final String choice2;
  final Color Colors;

  SlideButton({
    required this.onSelectionChanged,
    required this.choice1,
    required this.choice2,
    required this.Colors,
  });

  @override
  _SlideButtonState createState() => _SlideButtonState();
}

class _SlideButtonState extends State<SlideButton> {
  late String selectedChoice;

  @override
  void initState() {
    super.initState();
    selectedChoice = widget.choice1;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedChoice = (selectedChoice == widget.choice1)
              ? widget.choice2
              : widget.choice1;
          widget.onSelectionChanged(selectedChoice);
        });
      },
      child: Container(
        width: 130.0, // Adjust the width as needed
        height: 40.0, // Adjust the height as needed
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.white,
          border: Border.all(
            color: AppColors.primaryColor,
            width: 0.15,
          ),
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
        child: Stack(
          children: <Widget>[
            AnimatedPositioned(
              duration: Duration(milliseconds: 200),
              curve: Curves.ease,
              top: 0.0,
              left: (selectedChoice == widget.choice1)
                  ? 0.0
                  : 50.0, // Half of the width
              right: (selectedChoice == widget.choice1)
                  ? 50.0
                  : 0.0, // Half of the width
              child: Container(
                width: 80.0, // Half of the width
                height: 40.0, // Same height as the container
                decoration: BoxDecoration(
                  color: widget.Colors,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Center(
                  child: Text(
                    selectedChoice,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

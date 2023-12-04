import 'package:flutter/material.dart';
import 'package:gspappfinal/constants/AppColor.dart';
import 'package:gspappfinal/constants/AppTheme.dart';

class drawerComponent extends StatefulWidget {
  const drawerComponent({
    super.key,
    required this.name,
    required this.icon,
    required this.onChanged,
  });

  final String name;
  final IconData icon;
  final void Function()? onChanged;

  @override
  State<drawerComponent> createState() => _drawerComponentState();
}

class _drawerComponentState extends State<drawerComponent> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onChanged,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: MediaQuery.of(context).size.width * 0.10,
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  widget.icon,
                  color: AppColors.primaryColor,
                ),
                SizedBox(
                  width: 12,
                ),
                Text(
                  widget.name,
                  style: AppFonts.SubtitleColor(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

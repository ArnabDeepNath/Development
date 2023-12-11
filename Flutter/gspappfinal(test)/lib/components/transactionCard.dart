import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gspappfinal/constants/AppColor.dart';
import 'package:gspappfinal/constants/AppTheme.dart';

class transactionCard extends StatefulWidget {
  final String type;
  final double amount;
  final double balance;
  final String? name;
  const transactionCard({
    super.key,
    required this.type,
    required this.amount,
    required this.balance,
    required this.name,
  });

  @override
  State<transactionCard> createState() => _transactionCardState();
}

class _transactionCardState extends State<transactionCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Container(
          height: 120,
          width: MediaQuery.of(context).size.width * 0.9,
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ListTile(
                title: Text(
                  widget.name!,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                subtitle: Text(
                  'Balance: ${widget.balance}',
                ),
                leading: Text(
                  widget.type,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
                trailing: Text(
                  'Rs. ' + widget.amount.toString(),
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ),
              if (widget.type == 'Sale')
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          Icon(
                            Icons.edit,
                            color: Colors.black.withOpacity(0.7),
                          ),
                          Text(
                            ' Edit Transaction',
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
                      child: Row(
                        children: [
                          Icon(
                            Icons.cancel,
                            color: Colors.red.withOpacity(0.7),
                          ),
                          Text(
                            ' Delete Transaction',
                            style: AppFonts.Subtitle2(),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              else
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

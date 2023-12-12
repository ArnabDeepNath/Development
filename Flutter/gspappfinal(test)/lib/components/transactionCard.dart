import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gspappfinal/constants/AppColor.dart';
import 'package:gspappfinal/constants/AppTheme.dart';
import 'package:gspappfinal/controllers/PartyController.dart';

class transactionCard extends StatefulWidget {
  final double amount;
  final double balance;
  final String? name;
  final String transactionType;
  final String userId;
  final String partyId;
  final String transactionId;

  const transactionCard({
    super.key,
    required this.amount,
    required this.balance,
    required this.name,
    required this.transactionType,
    required this.partyId,
    required this.transactionId,
    required this.userId,
  });

  @override
  State<transactionCard> createState() => _transactionCardState();
}

class _transactionCardState extends State<transactionCard> {
  @override
  Widget build(BuildContext context) {
    return Center(
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
              trailing: Text(
                'Rs. ${widget.amount >= 0 ? widget.amount : widget.amount.abs()}',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ),
            if (widget.transactionType == 'pay')
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
                    onTap: () {
                      MainPartyController().deleteTransaction(
                          widget.userId, widget.partyId, widget.transactionId);
                    },
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
              Row(
                children: [],
              ),
          ],
        ),
      ),
    );
  }
}

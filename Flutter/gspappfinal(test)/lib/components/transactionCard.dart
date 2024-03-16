import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
  final bool isEditable;

  const transactionCard({
    super.key,
    required this.amount,
    required this.balance,
    required this.name,
    required this.transactionType,
    required this.partyId,
    required this.transactionId,
    required this.userId,
    required this.isEditable,
  });

  @override
  State<transactionCard> createState() => _transactionCardState();
}

class _transactionCardState extends State<transactionCard> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.15,
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
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Balance: ${widget.balance}',
                    ),
                    Text(
                      '${widget.transactionType == 'pay' ? 'Sale' : 'Purchase'}',
                      style: TextStyle(
                        color: widget.transactionType == 'pay'
                            ? Colors.green
                            : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                trailing: Text(
                  'Rs. ${widget.amount >= 0 ? widget.amount : widget.amount.abs()}',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: Colors.green.shade600,
                  ),
                ),
              ),
              if (widget.isEditable == true)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (widget.transactionType == 'pay')
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            // Handle generate payment out
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.payment_outlined,
                                color: Colors.black.withOpacity(0.7),
                              ),
                              Text(
                                'Payment Out',
                                style: AppFonts.Subtitle2(),
                              ),
                            ],
                          ),
                        ),
                      )
                    else if (widget.transactionType == 'receive')
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            // Handle payment in
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.payment_outlined,
                                color: Colors.black.withOpacity(0.7),
                              ),
                              Text(
                                ' Payment In',
                                style: AppFonts.Subtitle2(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          // Handle return
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.reply,
                              color: Colors.black.withOpacity(0.7),
                            ),
                            Text(
                              ' Return',
                              style: AppFonts.Subtitle2(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        PopupMenuButton<String>(
                          icon: Icon(Icons.more_vert),
                          onSelected: (String value) {
                            // Handle menu item selection
                            switch (value) {
                              case 'Option 1':
                                // Handle option 1
                                break;
                              case 'Option 2':
                                // Handle option 2
                                break;
                              case 'Option 3':
                                // Handle option 3
                                break;
                              case 'Option 4':
                                // Handle option 4
                                break;
                            }
                          },
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<String>>[
                            const PopupMenuItem<String>(
                              value: 'Return',
                              child: Text('Return'),
                            ),
                            const PopupMenuItem<String>(
                              value: 'Delivery Challan',
                              child: Text('Delivery Challan'),
                            ),
                            const PopupMenuItem<String>(
                              value: 'View/Share PDF',
                              child: Text('View/Share PDF'),
                            ),
                            const PopupMenuItem<String>(
                              value: 'View/Share Excel',
                              child: Text('View/Share Excel'),
                            ),
                          ],
                        ),
                      ],
                    ),
                    // InkWell(
                    //   onTap: () {
                    //     MainPartyController().deleteTransaction(widget.userId,
                    //         widget.partyId, widget.transactionId);
                    //   },
                    //   child: Row(
                    //     children: [
                    //       Icon(
                    //         Icons.cancel,
                    //         color: Colors.red.withOpacity(0.7),
                    //       ),
                    //       Text(
                    //         ' Delete Transaction',
                    //         style: AppFonts.Subtitle2(),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                )
              else
                Row(
                  children: [],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

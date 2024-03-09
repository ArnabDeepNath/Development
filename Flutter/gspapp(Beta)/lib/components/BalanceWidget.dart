import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gspappfinal/utils/BalanceProvider.dart';

class BalanceWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Consumer<BalanceProvider>(
        builder: (context, balanceProvider, child) {
          return StreamBuilder<double>(
            stream: balanceProvider.balanceStream,
            initialData: balanceProvider.balance,
            builder: (context, snapshot) {
              return Text('Balance: Rs. ${snapshot.data}');
            },
          );
        },
      ),
    );
  }
}

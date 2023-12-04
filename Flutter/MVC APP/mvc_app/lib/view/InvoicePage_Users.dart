import 'package:flutter/material.dart';
import 'package:mvc_app/view/addInvoicePage_Non_GST.dart';
import 'package:mvc_app/view/addInvoicePage_GST.dart';
import 'package:mvc_app/view/editInvoicePage_GST_admin.dart';
import 'package:mvc_app/view/editInvoicePage_NON_GST_users.dart';
import 'package:mvc_app/view/editInvoicePage_Non_GST_admin.dart';
import 'package:mvc_app/view/editInvoiePage_GST_users.dart';
import 'package:mvc_app/view/loginPage.dart';
import 'package:flutter/cupertino.dart';

class InvoicePage_users extends StatefulWidget {
  const InvoicePage_users({Key? key}) : super(key: key);

  @override
  _InvoicePage_usersState createState() => _InvoicePage_usersState();
}

class _InvoicePage_usersState extends State<InvoicePage_users> {
  int _selectedIndex = 0;
  static List<Widget> _invoicePages = <Widget>[
    addInvoice_Non_Gst(),
    addInvoice_Gst(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 50,
            child: CupertinoSegmentedControl<int>(
              children: const {
                0: Text('Non-GST'),
                1: Text('GST'),
              },
              onValueChanged: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              groupValue: _selectedIndex,
            ),
          ),
          Expanded(child: _invoicePages[_selectedIndex]),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 22,
            ),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.blue[200],
            ),
            child: DropdownButton(
              hint: Text('View Quotations'),
              value: null,
              items: const [
                DropdownMenuItem(
                  value: 'non-gst',
                  child: Text('Non-GST'),
                ),
                DropdownMenuItem(
                  value: 'gst',
                  child: Text('GST'),
                ),
              ],
              onChanged: (value) {
                if (value == 'non-gst') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => editInvoicePage_Non_GST_users(),
                    ),
                  );
                } else if (value == 'gst') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => editInvoicePage_GST_users(),
                    ),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

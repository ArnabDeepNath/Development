import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FilterBottomSheetView extends StatefulWidget {
  const FilterBottomSheetView();

  @override
  _FilterBottomSheetViewState createState() => _FilterBottomSheetViewState();
}

class _FilterBottomSheetViewState extends State<FilterBottomSheetView> {
  final _dateController = TextEditingController();
  String endDate = "";
  String startDate = "";
  List<String> listData = ['A-Z', '%', 'LTP', 'P&L', '%', '₹'];
  List<String> listData2 = [
    'Alphabetically',
    'Change',
    'Last Traded Price',
    'Profit & Loss',
    'Profit & Loss',
    'Invested'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450.0,
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Container(
              margin: const EdgeInsets.only(left: 10.0),
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Expanded(
                    child: Text(
                      'Filter',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF212121)),
                    ),
                  ),
                  Text(
                    'CLEAR',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                  SizedBox(width: 15.0)
                ],
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          Container(
            margin: const EdgeInsets.only(left: 20.0),
            padding: const EdgeInsets.only(
                left: 18.0, right: 18.0, top: 5.0, bottom: 5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(color: const Color(0xff888888)),
            ),
            child: const Text('Kite'),
          ),
          const SizedBox(height: 10.0),
          Divider(
            indent: 20.0,
            endIndent: 20.0,
            thickness: 2,
            color: Colors.grey.withOpacity(0.2),
          ),
          const SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Expanded(
                    child: Text(
                      'Sort',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF212121)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          for (var i = 0; i < listData.length; i++)
            Column(
              children: [
                const SizedBox(height: 5.0),
                Row(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        alignment: Alignment.topRight,
                        width: 50.0,
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          listData[i],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 15.0,
                          ),
                        )),
                    Container(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(listData2[i],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black.withOpacity(0.6),
                                fontSize: 15.0))),
                    Visibility(
                      visible: i == 3 || i == 4,
                      child: Container(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(i ==3 ? 'Absolute' : 'Percent',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey.withOpacity(0.7),
                                  fontSize: 15.0))),
                    )
                  ],
                ),
                const SizedBox(height: 10.0),
                Visibility(
                  visible: i != listData.length - 1,
                  child: Divider(
                    thickness: 2,
                    color: Colors.grey.withOpacity(0.2),
                  ),
                )
              ],
            )
        ],
      ),
    );
  }
}

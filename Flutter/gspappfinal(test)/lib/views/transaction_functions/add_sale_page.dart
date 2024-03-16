import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gspappfinal/components/BreakdownComponent.dart';
import 'package:gspappfinal/components/QtyControl.dart';
import 'package:gspappfinal/components/TextFormField.dart';
import 'package:gspappfinal/constants/AppColor.dart';
import 'package:gspappfinal/controllers/PartyController.dart';
import 'package:gspappfinal/models/TransactionsModel.dart';

class AddSalePage extends StatefulWidget {
  final String userId;
  final String partyId;
  final String partyName;
  final String userName;

  final String PgstId;
  AddSalePage({
    super.key,
    required this.userId,
    required this.partyId,
    required this.partyName,
    required this.PgstId,
    required this.userName,
  });

  // Party Name
  // GST ID
  // Total Amount
  // Items ->
  //

  @override
  State<AddSalePage> createState() => _AddSalePageState();
}

class _AddSalePageState extends State<AddSalePage> {
  TextEditingController PNameController = TextEditingController();
  TextEditingController GSTIDController = TextEditingController();
  TextEditingController TotalAmount = TextEditingController();
  TextEditingController Items = TextEditingController();
  int QtyController = 0;

  // Party Controller Intiliasation
  final MainPartyController PartyController = MainPartyController();

  // Fetching Items
  String? _selectedItem;
  List<String> _items = [];
  Map<String, Map<String, dynamic>> _itemDetails = {};
  Map<String, dynamic> _selectedItemDetails = {};

  List<Map<String, dynamic>> selectedItems = [];

  // Bool for Item Breakdown
  bool _itemSelected = false;

  @override
  void initState() {
    super.initState();
    _fetchItems();
    setState(() {
      PNameController.text = widget.partyName;
      GSTIDController.text = widget.PgstId;
    });
    // print('Fetched items: $_items');
  }

  Future<void> _fetchItems() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userId)
          .collection('items')
          .get();
      Map<String, Map<String, dynamic>> itemDetails = {};
      for (var doc in querySnapshot.docs) {
        String itemName = doc.get('itemName');
        Map<String, dynamic> details = {
          'itemName': doc.get('itemName'),
          'itemCpu': doc.get('itemCpu'),
          'itemUnit': doc.get('itemUnit'),
          // Add other details as needed
        };
        itemDetails[itemName] = details;
      }
      setState(() {
        _itemDetails = itemDetails;
        _items = _itemDetails.keys.toList();
      });
    } catch (e) {
      print('Error fetching items: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: AppBar(
        title: Text(
          'Add Sale',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormFieldCustom(
                  label: 'Party Name',
                  controller: PNameController,
                  onChange: (text) {},
                  validator: (text) {
                    return null;
                  },
                  obscureText: false),
              TextFormFieldCustom(
                  label: 'GSTIN',
                  controller: GSTIDController,
                  onChange: (text) {},
                  validator: (text) {
                    return null;
                  },
                  obscureText: false),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.6,
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
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton<String>(
                          value: _selectedItem,
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedItem = newValue!;
                              _selectedItemDetails =
                                  _itemDetails[_selectedItem] ?? {};
                            });
                          },
                          items: _items
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_selectedItem != null && QtyController > 0) {
                        double total = QtyController *
                            double.parse(
                                _selectedItemDetails['itemCpu'] ?? '0.0');

                        selectedItems.add({
                          'itemName': _selectedItem,
                          'qty': QtyController,
                          'total': (total * 28.87),
                        });
                        setState(() {
                          TotalAmount.text = selectedItems
                              .fold<int>(
                                  0,
                                  (sum, item) =>
                                      sum + (item['total'] as num).toInt())
                              .toStringAsFixed(2);
                        });
                      }
                    },
                    child: Text(
                      'Add/Edit',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  )
                ],
              ),
              QuantityController(
                onChanged: (value) {
                  // Handle quantity change if needed
                  QtyController = value;
                },
                onItemSelected: (selected) {
                  setState(() {
                    _itemSelected = QtyController >= 1 ? selected : false;
                  });
                },
              ),
              Visibility(
                visible: _itemSelected,
                child: BreakDownComponent(
                  qty: QtyController,
                  unit: _selectedItemDetails['itemUnit'] ?? 'NA',
                  cpu: _selectedItemDetails['itemCpu'] ?? '0.0',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.6,
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
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: selectedItems.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(selectedItems[index]['itemName']),
                        subtitle: Text('Qty: ${selectedItems[index]['qty']}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Total: ${double.parse(selectedItems[index]['total'].toString()).toStringAsFixed(2)}',
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                setState(() {
                                  selectedItems.removeAt(index);
                                });
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              TextFormFieldCustom(
                  label: 'Total',
                  controller: TotalAmount,
                  onChange: (text) {},
                  validator: (text) {
                    return null;
                  },
                  obscureText: false),
              TextFormFieldCustom(
                  label: 'Balance',
                  controller: GSTIDController,
                  onChange: (text) {},
                  validator: (text) {
                    return null;
                  },
                  obscureText: false),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      PartyController.addSale(
                        widget.partyId,
                        double.parse(TotalAmount.text),
                        widget.userId,
                        widget.userName,
                      );
                      // PartyController.addTransactionToParty(
                      //     widget.partyId,
                      //     TransactionsMain(
                      //       amount: 0,
                      //       description: '',
                      //       timestamp: Timestamp.fromDate(
                      //         DateTime.now(),
                      //       ),
                      //       reciever: widget.partyName,
                      //       sender: widget.userId,
                      //       balance: 0,
                      //       isEditable: false,
                      //       recieverName: widget.partyName,
                      //       recieverId: widget.partyId,
                      //       transactionType: '',
                      //       transactionId: '',
                      //       senderName: '',
                      //     ),
                      //     widget.userId);
                    },
                    child: const Text('Save'),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Delete'),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

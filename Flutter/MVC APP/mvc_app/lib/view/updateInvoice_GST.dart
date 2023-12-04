import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mvc_app/controller/invoiceController_GST.dart';
import 'package:mvc_app/model/carModel.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';
import 'package:share/share.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';
import '../controller/recordsController.dart';

class updateInvoice_GST extends StatefulWidget {
  String selectedLob;
  String selectedModel;
  String quotation_no;
  Timestamp date;
  String name;
  String address;
  String phonenumber;
  String email;
  String pan_id;
  String opt_id;
  int scheme = 0;
  double tcs = 0;
  double exShowRoomPrice = 0;
  int qty = 1;
  double hsrp = 0;
  double regn = 0;
  double temp_regn = 0;
  double totalTax = 0;
  double totalAfterTax = 0;
  List items;
  String gstId;

  updateInvoice_GST({
    super.key,
    required this.selectedLob,
    required this.selectedModel,
    required this.quotation_no,
    required this.date,
    required this.name,
    required this.address,
    required this.phonenumber,
    required this.email,
    required this.pan_id,
    required this.opt_id,
    required this.scheme,
    required this.tcs,
    required this.exShowRoomPrice,
    required this.qty,
    required this.hsrp,
    required this.regn,
    required this.temp_regn,
    required this.totalTax,
    required this.totalAfterTax,
    required this.items,
    required this.gstId,
  });

  @override
  State<updateInvoice_GST> createState() => _updateInvoice_GSTState();
}

class _updateInvoice_GSTState extends State<updateInvoice_GST> {
  final _formKey = GlobalKey<FormState>();
  List items = [];
  String itemName = '';
  int itemQuantity = 0;

  double _calculateTotal() {
    double total = 0;
    int itemCount = items.length;
    for (int i = 0; i < itemCount; i++) {
      total += items[i]['quantity'];
    }
    return total;
  }

  void _deleteItem(int index) {
    setState(() {
      items.removeAt(index);
    });
  }

  TextEditingController quotationNoController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController nameNoController = TextEditingController();
  TextEditingController addressNoController = TextEditingController();
  TextEditingController phonenumberNoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController panidController = TextEditingController();
  TextEditingController optidController = TextEditingController();
  TextEditingController schemeController = TextEditingController();
  TextEditingController tcsController = TextEditingController();
  TextEditingController gstController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      setState(() {});
    });
    getLobs();
    getCurrentUserId();
    print(widget.tcs);
    selectedLob = widget.selectedLob;
    getModels(selectedLob!);
    _quotation_no = widget.quotation_no;
    selectedModel = widget.selectedModel;

    // Assuming `widget.date` is a Firebase timestamp
    Timestamp timestamp = widget.date;
    DateTime dateTime = timestamp.toDate();

    // Format the DateTime object into a string using DateFormat
    String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);

    print(
        formattedDate); // This will print the date in the format "dd-MM-yyyy", e.g. "19-04-2023"

    _date = widget.date;
    _name = widget.name;
    _address = widget.address;
    _phonenumber = widget.phonenumber;
    _email = widget.email;
    _pan_id = widget.pan_id;
    _opt_id = widget.opt_id;
    _scheme = widget.scheme;
    _tcs = widget.tcs;
    gst = widget.gstId;
    quotationNoController.text = widget.quotation_no;
    dateController.text = formattedDate;
    nameNoController.text = widget.name;
    addressNoController.text = widget.address;
    phonenumberNoController.text = widget.phonenumber;
    emailController.text = widget.email;
    panidController.text = widget.pan_id;
    optidController.text = widget.opt_id;
    schemeController.text = widget.scheme.toString();
    tcsController.text = widget.tcs.toString();
    gstController.text = widget.gstId;
    items = widget.items;
  }

  Future<String> getCurrentUserId() async {
    final User? user = FirebaseAuth.instance.currentUser;
    final String uid = user!.uid;
    final DocumentSnapshot userSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    final String? username = userSnapshot.get('Name');
    setState(() {
      _uid = uid;
      _username = username;
    });
    print(_username);
    return uid;
  }

  late String _uid;
  late String? _username;
  void getLobs() async {
    QuerySnapshot querySnapshot =
        await _firestore.collection('cars').orderBy('lob').get();

    setState(() {
      lobs = [];
      models = [];
      cars = [];
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        String lob = data['lob'];

        if (!lobs.contains(lob)) {
          lobs.add(lob);
        }
      }
    });
  }

  void getModels(String lob) async {
    print('getModels called with lob: $lob');
    QuerySnapshot querySnapshot =
        await _firestore.collection('cars').where('lob', isEqualTo: lob).get();

    setState(() {
      models = [];
      cars = [];
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        String model = data['model'];

        if (!models.contains(model)) {
          models.add(model);
        }
      }
    });
  }

  void getCars(String lob, String model) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('cars')
        .where('lob', isEqualTo: lob)
        .where('model', isEqualTo: model)
        .get();

    setState(() {
      cars = [];
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        Car car = Car.fromFirestore(doc);
        cars.add(car);
        grandTotal = cars[0].exShowroomPrice;
      }
    });
  }

  int _quantity = 1;
  void _calEvery() {
    setState(() {
      // regn = (cars[0].registration) * _quantity;
      grandTotal = ((cars[0].exShowroomPrice) * _quantity);
      // print(cars[0].exShowroomPrice * _quantity);
      int scheme = 0;
      int totalScheme = scheme * _quantity;
      grandTotal = grandTotal - totalScheme;
      double tcs = grandTotal * 0.010;
      totalTax = (tcs + regn);
      totalAfterTax = grandTotal - totalTax;
    });
  }

  double grandTotal = 0;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<String> lobs = [];
  List<String> models = [];
  String? selectedLob;
  String? selectedModel;
  List<Car> cars = [];
  String? _quotation_no;
  Timestamp? _date;
  String? _name;
  String? _address;
  String? _phonenumber;
  String? _email;
  String? _pan_id;
  String? _opt_id;
  String? _gst_id;
  late int _scheme = 0;
  late double _tcs = 0;
  late double exShowroomPrice = 0;
  late int qty = 1;
  late double temp = 0;
  late double regn = 0;
  late double hsrp = 0;
  late double totalTax = 0;
  late double totalAfterTax = 0;
  late String gst;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Invoice GST '),
      ),
      backgroundColor: Colors.grey[400],
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 22,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                decoration: BoxDecoration(
                  color: Colors.blue[400],
                ),
                child: TextField(
                  controller: quotationNoController,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    border: InputBorder.none,
                    hintText: 'Quatotation Number: ',
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _quotation_no = value;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 22,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                decoration: BoxDecoration(
                  color: Colors.blue[400],
                ),
                child: TextField(
                  controller: dateController,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    border: InputBorder.none,
                    hintText: 'Date: ',
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onChanged: ((value) {
                    setState(() {
                      _date = value as Timestamp?;
                    });
                  }),
                ),
              ),
            ),
            const SizedBox(
              height: 22,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                decoration: BoxDecoration(
                  color: Colors.blue[400],
                ),
                child: TextField(
                  controller: nameNoController,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    border: InputBorder.none,
                    hintText: 'Name: ',
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onChanged: ((value) {
                    setState(() {
                      _name = value;
                    });
                  }),
                ),
              ),
            ),
            const SizedBox(
              height: 22,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                decoration: BoxDecoration(
                  color: Colors.blue[400],
                ),
                child: TextField(
                  controller: addressNoController,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    border: InputBorder.none,
                    hintText: 'Address: ',
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onChanged: ((value) {
                    setState(() {
                      _address = value;
                    });
                  }),
                ),
              ),
            ),
            const SizedBox(
              height: 22,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                decoration: BoxDecoration(
                  color: Colors.blue[400],
                ),
                child: TextField(
                  controller: phonenumberNoController,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    border: InputBorder.none,
                    hintText: 'Phone Number: ',
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onChanged: ((value) {
                    setState(() {
                      _phonenumber = value;
                    });
                  }),
                ),
              ),
            ),
            const SizedBox(
              height: 22,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                decoration: BoxDecoration(
                  color: Colors.blue[400],
                ),
                child: TextField(
                  controller: emailController,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    border: InputBorder.none,
                    hintText: 'Email: ',
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onChanged: ((value) {
                    setState(() {
                      _email = value;
                    });
                  }),
                ),
              ),
            ),
            const SizedBox(
              height: 22,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                decoration: BoxDecoration(
                  color: Colors.blue[400],
                ),
                child: TextField(
                  controller: panidController,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    border: InputBorder.none,
                    hintText: 'PAN ID: ',
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onChanged: ((value) {
                    setState(() {
                      _pan_id = value;
                    });
                  }),
                ),
              ),
            ),
            const SizedBox(
              height: 22,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                decoration: BoxDecoration(
                  color: Colors.blue[400],
                ),
                child: TextField(
                  controller: optidController,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    border: InputBorder.none,
                    hintText: 'OPY ID: ',
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onChanged: ((value) {
                    setState(() {
                      _opt_id = value;
                    });
                  }),
                ),
              ),
            ),

            ListView.builder(
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                final itemName = item['name'];
                final itemQuantity = item['quantity'];

                return ListTile(
                  title: Text(itemName),
                  subtitle: Text(itemQuantity.toString()),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              String editedName = itemName;
                              int editedQuantity = itemQuantity;

                              return AlertDialog(
                                title: Text('Edit Item'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextField(
                                      onChanged: (value) {
                                        editedName = value;
                                      },
                                      decoration: InputDecoration(
                                        hintText: 'Item Name',
                                      ),
                                      controller: TextEditingController(
                                        text: editedName,
                                      ),
                                    ),
                                    TextField(
                                      onChanged: (value) {
                                        editedQuantity =
                                            int.tryParse(value) ?? 0;
                                      },
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        hintText: 'Item Quantity',
                                      ),
                                      controller: TextEditingController(
                                        text: editedQuantity.toString(),
                                      ),
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Perform any additional update or validation logic if needed

                                      // Update the item in the items list
                                      setState(() {
                                        items[index]['name'] = editedName;
                                        items[index]['quantity'] =
                                            editedQuantity;
                                      });

                                      // Close the dialog
                                      Navigator.pop(context);
                                    },
                                    child: Text('Save'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            items.removeAt(index);
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(
              height: 22,
            ),
            const Text(
              'Select Lob:',
              style: TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 10.0),
            DropdownButton<String>(
              value: selectedLob, // updated to use the selectedLob variable
              onChanged: (String? newValue) {
                setState(() {
                  selectedLob = newValue!;

                  models.clear();
                  cars.clear();
                  getModels(selectedLob!);
                });
              },
              items: lobs.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),

            const SizedBox(height: 20.0),
            const Text(
              'Select Model:',
              style: TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 10.0),
            DropdownButton<String>(
              value: selectedModel,
              onChanged: (String? newValue) {
                setState(() {
                  selectedModel = newValue!;
                  getCars(selectedLob!, selectedModel!);
                  _calEvery();
                });
              },
              items: models.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),

            // Function to Add Scheme
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                decoration: BoxDecoration(
                  color: Colors.blue[400],
                ),
                child: TextField(
                  controller: schemeController,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    border: InputBorder.none,
                    hintText: 'Scheme: ',
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onChanged: ((value) {
                    setState(() {
                      _scheme = int.parse(value);
                      _calEvery();
                    });
                  }),
                ),
              ),
            ),
            const SizedBox(
              height: 22,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                decoration: BoxDecoration(
                  color: Colors.blue[400],
                ),
                child: TextFormField(
                  controller: gstController,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    border: InputBorder.none,
                    hintText: 'GST ID: ',
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onChanged: ((value) {
                    setState(() {
                      _gst_id = value;
                    });
                  }),
                ),
              ),
            ),
            const SizedBox(
              height: 22,
            ),
            // Function to add TCS

            MaterialButton(
              color: Colors.blue[400],
              child: Text('Clear Car'),
              onPressed: () {
                setState(() {
                  selectedModel = null;
                  models.clear();
                });
              },
            ),
            Text('Grand Total: Rs. $grandTotal'),
            const SizedBox(
              height: 22,
            ),

            MaterialButton(
              color: Colors.blue[400],
              onPressed: () async {
                FirebaseService().updateInvoice_GST(
                  _quotation_no,
                  _date!,
                  _name,
                  _address,
                  _phonenumber,
                  _email,
                  _pan_id,
                  _gst_id,
                  _opt_id,
                  true,
                  selectedLob.toString(),
                  selectedModel.toString(),
                  exShowroomPrice,
                  qty,
                  _tcs,
                  hsrp,
                  temp,
                  regn,
                  _scheme,
                  grandTotal,
                  0.0,
                  0.0,
                  0.0,
                  0.0,
                  totalAfterTax,
                  totalTax,
                  items,
                  _uid,
                  _uid,
                );
                // print(_quotation_no!);
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) =>
                //         PDFViewerScreen(filePath: filePath, share: true),
                //   ),
                // );
                Navigator.pop(context);
              },
              child: Text("Update PDF"),
            ),
          ],
        ),
      ),
    );
  }
}

class PDFViewerScreen extends StatelessWidget {
  final String filePath;
  final bool share;

  PDFViewerScreen({
    Key? key,
    required this.filePath,
    this.share = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Invoice"),
        actions: [
          if (share)
            IconButton(
              icon: const Icon(Icons.share),
              onPressed: () async {
                await Share.share(filePath);
              },
            ),
        ],
      ),
      body: PdfView(path: filePath),
    );
  }
}

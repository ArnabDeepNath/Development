import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mvc_app/controller/invoiceController_GST.dart';
import 'package:mvc_app/controller/invoiceController_Non_GST.dart';
import 'package:mvc_app/main.dart';
import 'package:mvc_app/model/carModel.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';
import 'package:share/share.dart';
import 'package:firebase_core/firebase_core.dart';

import '../controller/recordsController.dart';

class addInvoice_Non_Gst extends StatefulWidget {
  addInvoice_Non_Gst({super.key});

  @override
  State<addInvoice_Non_Gst> createState() => _addInvoice_Non_GstState();
}

class _addInvoice_Non_GstState extends State<addInvoice_Non_Gst> {
  final _formKey = GlobalKey<FormState>();
  void _deleteItem(int index) {
    setState(() {
      items.removeAt(index);
    });
  }

  List<Map<String, dynamic>> items = [];

  String itemName = '';
  int itemQuantity = 0;
  double itemPrice = 0;

  void _addItem() {
    if (itemName.isNotEmpty && itemQuantity > 0 && itemPrice > 0) {
      setState(() {
        items.add({
          'name': itemName,
          'quantity': itemQuantity,
          'price': itemPrice,
        });
        itemName = '';
        itemQuantity = 0;
        itemPrice = 0;
      });
    }
  }

  void _showAddItemDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  itemName = value;
                },
                decoration: InputDecoration(
                  hintText: 'Item Name',
                ),
              ),
              TextField(
                onChanged: (value) {
                  itemQuantity = int.tryParse(value) ?? 0;
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Item Quantity',
                ),
              ),
              TextField(
                onChanged: (value) {
                  itemPrice = double.tryParse(value) ?? 0;
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Item Price',
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
                _addItem();
                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  double _calculateTotal() {
    double total = 0;
    int itemCount = items.length;
    for (int i = 0; i < itemCount; i++) {
      total += items[i]['quantity'] * items[i]['price'];
    }
    return total;
  }

  void _calEvery() {
    setState(() {
      // regn = (cars[0].registration) * _quantity;
      grandTotal = ((cars[0].exShowroomPrice) * _quantity);
      // print(cars[0].exShowroomPrice * _quantity);
      int totalScheme = scheme * _quantity;
      grandTotal = grandTotal - totalScheme;
      tcs = grandTotal * 0.010;
      totalTax = (tcs + regn);
      totalAfterTax = grandTotal + totalTax;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      setState(() {});
    });
    getLobs();
    getCurrentUserId();
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
        // temp = cars[0].tempRegistration;
        // tcsController.text = cars[0].handlingServiceCharge.toString();
        // grandTotal = ((cars[0].exShowroomPrice) * _quantity);
        // tcs = grandTotal * 0.010;
        // regn = (cars[0].registration) * _quantity;
        _calEvery();
      }
    });
  }

  int _quantity = 1;

  void incrementQuantity() {
    setState(() {
      _quantity++;
      scheme = 0;
      regn = (cars[0].registration) * _quantity;
      grandTotal = ((cars[0].exShowroomPrice) * _quantity);
      tcs = grandTotal * 0.010;
      totalTax = (tcs + regn);
      totalAfterTax = (grandTotal + totalTax);
    });
  }

  void decrementQuantity() {
    setState(() {
      if (_quantity > 1) {
        _quantity--;
        scheme = 0;
        regn = (cars[0].registration) * _quantity;
        grandTotal = ((cars[0].exShowroomPrice) * _quantity);
        tcs = grandTotal * 0.010;
        totalTax = (tcs + regn);
        totalAfterTax = (grandTotal + totalTax);
      }
    });
  }

  TextEditingController schemeController = TextEditingController();

  double exShowroomPrice = 0;
  double regn = 0;
  double temp = 0;
  int scheme = 0;
  double tcs = 0.0;
  double grandTotal = 0.0;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<String> lobs = [];
  List<String> models = [];
  String? selectedLob;
  String? selectedModel;
  List<Car> cars = [];
  late String _quotation_no;
  Timestamp _date = Timestamp.now();
  late String _name;
  late String _address;
  late String _phonenumber;
  late String _email;
  late String _pan_id;
  late String _opt_id;
  late double totalTax = 0;
  late double totalAfterTax = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quotation Non GST'),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 22,
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 12.0),
              //   child: Container(
              //     padding: const EdgeInsets.symmetric(horizontal: 22),
              //     decoration: BoxDecoration(
              //       color: Colors.blue[400],
              //     ),
              //     child: TextFormField(
              //       style: const TextStyle(
              //         color: Colors.white,
              //       ),
              //       decoration: const InputDecoration(
              //         labelStyle: TextStyle(
              //           color: Colors.white,
              //         ),
              //         border: InputBorder.none,
              //         hintText: 'Quatotation Number: ',
              //         hintStyle: TextStyle(
              //           color: Colors.white,
              //         ),
              //       ),
              //       onChanged: (value) {
              //         setState(() {
              //           _quotation_no = value;
              //         });
              //       },
              //       validator: (value) {
              //         if (value!.isEmpty) {
              //           return 'Please enter a valid Quotation Number';
              //         }
              //         return null;
              //       },
              //     ),
              //   ),
              // ),
              // const SizedBox(
              //   height: 22,
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 12.0),
              //   child: Container(
              //     padding: const EdgeInsets.symmetric(horizontal: 22),
              //     decoration: BoxDecoration(
              //       color: Colors.blue[400],
              //     ),
              //     child: TextFormField(
              //       keyboardType: TextInputType.datetime,
              //       style: const TextStyle(
              //         color: Colors.white,
              //       ),
              //       decoration: const InputDecoration(
              //         labelStyle: TextStyle(
              //           color: Colors.white,
              //         ),
              //         border: InputBorder.none,
              //         hintText: 'Date: ',
              //         hintStyle: TextStyle(
              //           color: Colors.white,
              //         ),
              //       ),
              //       onChanged: ((value) {
              //         setState(() {
              //           // Assuming value is a valid date string in the format 'yyyy-MM-dd'
              //           DateTime selectedDate = DateTime.parse(value);
              //           _date = Timestamp.fromDate(selectedDate);
              //           setState(
              //             () {},
              //           ); // Trigger a state update to reflect the new value
              //         });
              //       }),
              //       validator: (value) {
              //         if (value!.isEmpty) {
              //           return 'Please enter a valid Date in dd-mm-yyyy format';
              //         }
              //         return null;
              //       },
              //     ),
              //   ),
              // ),
              // const SizedBox(
              //   height: 22,
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  decoration: BoxDecoration(
                    color: Colors.blue[400],
                  ),
                  child: TextFormField(
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a valid Name';
                      }
                      return null;
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
                  child: TextFormField(
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a valid Name';
                      }
                      return null;
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
                  child: TextFormField(
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a valid Name';
                      }
                      return null;
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
                  child: TextFormField(
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a valid Name';
                      }
                      return null;
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
                  child: TextFormField(
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a valid Name';
                      }
                      return null;
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
                  child: TextFormField(
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a valid Name';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 22,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Quantity:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  InkWell(
                    onTap: decrementQuantity,
                    child: const Icon(Icons.remove_circle_outline),
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    '$_quantity',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  InkWell(
                    onTap: incrementQuantity,
                    child: const Icon(Icons.add_circle_outline),
                  ),
                ],
              ),
              const SizedBox(
                height: 22,
              ),
              const Text(
                'Select Lob:',
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                width: MediaQuery.of(context).size.width * .6,
                child: DropdownButton<String>(
                  elevation: 20,
                  value: selectedLob,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedLob = newValue!;
                      selectedModel = null; // reset the selectedModel variable
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
                  });
                },
                items: models.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 12.0),
              //   child: Container(
              //     padding: const EdgeInsets.symmetric(horizontal: 22),
              //     decoration: BoxDecoration(
              //       color: Colors.blue[400],
              //     ),
              //     child: TextFormField(
              //       keyboardType: TextInputType.number,
              //       controller: schemeController,
              //       onChanged: ((value) {
              //         setState(() {
              //           scheme = int.parse(value);
              //           _calEvery();
              //         });
              //       }),
              //       validator: (value) {
              //         if (value!.isEmpty) {
              //           return 'Please enter a valid Scheme amount';
              //         }
              //         return null;
              //       },
              //       style: const TextStyle(
              //         color: Colors.white,
              //       ),
              //       decoration: const InputDecoration(
              //         labelStyle: TextStyle(
              //           color: Colors.white,
              //         ),
              //         border: InputBorder.none,
              //         hintText: 'Scheme: ',
              //         hintStyle: TextStyle(
              //           color: Colors.white,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              // const SizedBox(
              //   height: 12,
              // ),
              ElevatedButton(
                onPressed: _showAddItemDialog,
                child: const Text('Add Item'),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(items[index]['name']),
                    subtitle: Text('${items[index]['quantity']}'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        _deleteItem(index);
                      },
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 12,
              ),
              Text('Scheme: Rs. $scheme'),
              const SizedBox(
                height: 12,
              ),
              Text('TCS 1%: Rs. $tcs'),
              const SizedBox(
                height: 12,
              ),
              Text('Registration: Rs. $regn'),
              const SizedBox(
                height: 12,
              ),
              Text('Items Cost : Rs . ${_calculateTotal()}'),
              const SizedBox(
                height: 12,
              ),
              Text('Total Tax: Rs. $totalTax'),
              const SizedBox(
                height: 12,
              ),
              Text('Grand Total (Before Tax): Rs. $grandTotal'),
              const SizedBox(
                height: 12,
              ),
              Text('Total After Tax: Rs. $totalAfterTax'),
              const SizedBox(
                height: 12,
              ),
              MaterialButton(
                color: Colors.blue[400],
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    try {
                      _calEvery();
                      String filePath = await generatePDF_Non_GST(
                        _quotation_no,
                        _date,
                        _name,
                        _address,
                        _phonenumber,
                        _email,
                        _pan_id,
                        '',
                        _opt_id,
                        false,
                        cars[0].lob,
                        cars[0].model,
                        cars[0].exShowroomPrice,
                        _quantity,
                        tcs,
                        cars[0].handlingServiceCharge,
                        cars[0].tempRegistration,
                        cars[0].registration,
                        scheme,
                        grandTotal,
                        0,
                        0,
                        0,
                        0,
                        totalAfterTax,
                        totalTax,
                        items,
                        _username!,
                        _uid,
                        PdfPageFormat(
                            PdfPageFormat.a4.width, PdfPageFormat.a4.height),
                      );
                      FirebaseService().saveInvoice_Non_GST(
                        _quotation_no,
                        _date.toString(),
                        _name,
                        _address,
                        _phonenumber,
                        _email,
                        _pan_id,
                        '',
                        _opt_id,
                        false,
                        cars[0].lob,
                        cars[0].model,
                        cars[0].exShowroomPrice,
                        _quantity,
                        tcs,
                        cars[0].handlingServiceCharge,
                        cars[0].tempRegistration,
                        cars[0].registration,
                        scheme,
                        grandTotal,
                        0,
                        0,
                        0,
                        0,
                        totalTax,
                        totalAfterTax,
                        items,
                        _username!,
                        _uid,
                      );
                      // ignore: use_build_context_synchronously
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PDFViewerScreen(
                            filePath: filePath,
                            share: true,
                          ),
                        ),
                      );
                      setState(() {
                        _formKey.currentState!.reset();
                        selectedLob = null;
                        selectedModel = null;
                        schemeController.clear();
                        items = [];
                      });
                    } catch (error) {
                      // Show an error message if there's an issue adding the car
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Error adding car: $error'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    } // Show an error message if there's an issue adding the car
                  }
                },
                child: const Text(
                  'Generate',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
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

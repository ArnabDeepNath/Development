import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mvc_app/components/checkboxComponent.dart';
import 'package:mvc_app/controller/invoiceController_GST.dart';
import 'package:mvc_app/model/carModel.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';
import 'package:share/share.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';
import '../controller/recordsController.dart';
import 'package:uuid/uuid.dart';

class addInvoice_Gst extends StatefulWidget {
  addInvoice_Gst({super.key});

  @override
  State<addInvoice_Gst> createState() => _addInvoice_GstState();
}

class _addInvoice_GstState extends State<addInvoice_Gst> {
  final _formKey = GlobalKey<FormState>();
  @override
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
        // scheme = cars[0].insurance;
        // temp = cars[0].tempRegistration;
        // tcsController.text = cars[0].handlingServiceCharge.toString();
        // grandTotal = ((cars[0].exShowroomPrice) * _quantity);
        // tcs = grandTotal * 0.010;
        // regn = (cars[0].registration) * _quantity;
        _calEvery();
      }
      // print((cars[0].exShowroomPrice));
    });
  }

  int _quantity = 1;

  void incrementQuantity() {
    setState(() {
      _quantity++;
      // tcsController.clear();
      // tcsController.text = '0';
      // scheme = 0;
      // regn = (cars[0].registration) * _quantity;
      // grandTotal = (cars[0].exShowroomPrice) * _quantity;
      // tcs = grandTotal * 0.010;
      _calEvery();
    });
  }

  void decrementQuantity() {
    setState(() {
      if (_quantity > 1) {
        _quantity--;
        // tcsController.clear();
        // tcsController.text = '0';
        // scheme = 0;
        // regn = (cars[0].registration) * _quantity;
        // grandTotal = (cars[0].exShowroomPrice) * _quantity;
        // tcs = grandTotal * 0.010;
        _calEvery();
      }
    });
  }

  void _calEvery() {
    setState(() {
      exShowroomPrice = cars[0].exShowroomPrice;
      regn = (cars[0].registration) * _quantity;
      grandTotal = ((cars[0].exShowroomPrice) * _quantity);
      // print(cars[0].exShowroomPrice * _quantity);
      calculateTCS(cars[0].exShowroomPrice);
      calculateGST(cars[0].exShowroomPrice, cars[0].gstPer);
      scheme = 0; // Initialize scheme to 0 before calculating

      for (var checkbox in selectedCheckboxes) {
        int value = checkbox['value'] ?? 0;
        scheme += value;
      }
      int totalScheme = scheme * _quantity;
      grandTotal = grandTotal - totalScheme;
      // calculateGST(48);
      totalTax = (tcs + regn + sgst + cgst);
      totalAfterTax = grandTotal + totalTax;
      // print(scheme);
    });
  }

  void _deleteItem(int index) {
    setState(() {
      items.removeAt(index);
    });
  }

  TextEditingController schemeController = TextEditingController();

  double exShowroomPrice = 0.0;
  double sgst = 0.0;
  double cgst = 0.0;
  double igst = 0.0;
  double totalTax = 0.0;
  double totalAfterTax = 0.0;
  double regn = 0;
  double temp = 0;
  int scheme = 0;
  double tcs = 0.0;
  double grandTotal = 0;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<String> lobs = [];
  List<String> models = [];
  String? selectedLob;
  String? selectedModel;
  List<Car> cars = [];
  String _quotation_no = '';
  Timestamp _date = Timestamp.now();
  late String _name;
  late String _address;
  late String _phonenumber;
  late String _email;
  late String _pan_id;
  late String _opt_id;
  late String _gst_id;
  List<Map<String, dynamic>> selectedCheckboxes = [];

  void handleCheckboxChanged(List<Map<String, dynamic>> checkboxes) {
    setState(() {
      selectedCheckboxes = checkboxes;
      // You can perform any additional logic or updates here
      _calEvery();
    });
  }

  String generateQuotationNumber() {
    final DateFormat formatter = DateFormat('yyyyMMddHHmmss');
    final String timestamp = formatter.format(DateTime.now());
    const String prefix =
        'MM'; // You can customize the prefix as per your preference
    setState(() {
      _quotation_no = '$prefix$timestamp';
    });
    return '$prefix$timestamp';
  }

  void calculateGST(double exshowroomprice, int gstPercentage) {
    setState(() {
      cgst = exshowroomprice * ((gstPercentage / 2) / 100);
      sgst = exshowroomprice * ((gstPercentage / 2) / 100);
      igst = exshowroomprice * (gstPercentage / 100);
    });
    print('CGST: $cgst');
    // print('SGST: $sgst%');
    // print('IGST: $igst%');
  }

  num calculateTCS(double exShowroomPrice) {
    if (exShowroomPrice > 1000000) {
      setState(() {
        tcs = exShowroomPrice * 0.01;
      });
      return exShowroomPrice * 0.01; // 1% tax rate for prices above 10L
    } else {
      return 0; // No TCS for prices below or equal to 10L
    }
  }

  final welcomeController = TextEditingController();
  final captiveController = TextEditingController();
  final loyaltyController = TextEditingController();
  final cdController = TextEditingController();
  final exchangeController = TextEditingController();
  final mithilaDiscountController = TextEditingController();
  final amcCancController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quotation GST'),
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
                      hintText: 'Quotation Number: ',
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    initialValue:
                        generateQuotationNumber(), // Set initial value
                    enabled: false, // Disable editing
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
                    keyboardType: TextInputType.datetime,
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
                    readOnly: true, // Set the field as read-only
                    controller: TextEditingController(
                      text: DateFormat('dd-MM-yyyy').format(DateTime
                          .now()), // Set the current date as the initial value
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a valid Date in dd-mm-yyyy format';
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
                        return 'Please enter a valid Address';
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
                        return 'Please enter a valid Phone Number';
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
                        return 'Please enter a valid Email Address';
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
                        return 'Please enter a valid PAN ID';
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a valid GST ID';
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
                      hintText: 'OPTY ID: ',
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
                        return 'Please enter a valid OPTY ID';
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
                    // print(cars[0].exShowroomPrice);
                    // print(grandTotal);
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

              CustomCheckboxComponent(
                title: 'CD/NFA/UFD',
                maxValue: 5000,
                controller: cdController,
                selectedCheckboxes: selectedCheckboxes,
                onCheckboxChanged: handleCheckboxChanged,
              ),
              CustomCheckboxComponent(
                title: 'Captive',
                maxValue: 3333,
                controller: captiveController,
                selectedCheckboxes: selectedCheckboxes,
                onCheckboxChanged: handleCheckboxChanged,
              ),
              CustomCheckboxComponent(
                title: 'Loyalty',
                maxValue: 4444,
                controller: loyaltyController,
                selectedCheckboxes: selectedCheckboxes,
                onCheckboxChanged: handleCheckboxChanged,
              ),
              CustomCheckboxComponent(
                title: 'Welcome',
                maxValue: 5555,
                controller: welcomeController,
                selectedCheckboxes: selectedCheckboxes,
                onCheckboxChanged: handleCheckboxChanged,
              ),
              CustomCheckboxComponent(
                title: 'Exchange',
                maxValue: 6666,
                controller: exchangeController,
                selectedCheckboxes: selectedCheckboxes,
                onCheckboxChanged: handleCheckboxChanged,
              ),
              CustomCheckboxComponent(
                title: 'Mithila Discount',
                maxValue: 7777,
                controller: mithilaDiscountController,
                selectedCheckboxes: selectedCheckboxes,
                onCheckboxChanged: handleCheckboxChanged,
              ),
              CustomCheckboxComponent(
                title: 'Amc Cancellation',
                maxValue: 5000,
                controller: amcCancController,
                selectedCheckboxes: selectedCheckboxes,
                onCheckboxChanged: handleCheckboxChanged,
              ),
              const SizedBox(
                height: 12,
              ),
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
              ListView.builder(
                shrinkWrap: true,
                itemCount: selectedCheckboxes.length,
                itemBuilder: (context, index) {
                  final checkbox = selectedCheckboxes[index];
                  final title = checkbox['title'];
                  final value = checkbox['value'];

                  return ListTile(
                    title: Text(title),
                    subtitle: Text('Value: $value'),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Ex-ShowRoom Price:',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              'Rs. $exShowroomPrice',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'TCS @ 1%:',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              'Rs. $tcs',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'SGST:',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              'Rs. $sgst',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'CGST:',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              'Rs. $cgst',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Registration:',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              'Rs. $regn',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 2,
                        child: Container(
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total Tax:',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              'Rs. $totalTax',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total Scheme:',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              '- Rs. $scheme',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 2,
                        child: Container(
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Grand Total:',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              'Rs. $totalAfterTax',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'Items Cost : ${_calculateTotal()}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                    ],
                  ),
                ),
              ),

              MaterialButton(
                color: Colors.blue[400],
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      _calEvery();

                      String filePath = await generatePDF_GST(
                        _quotation_no,
                        _date,
                        _name,
                        _address,
                        _phonenumber,
                        _email,
                        _pan_id,
                        _gst_id,
                        _opt_id,
                        true,
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
                        sgst,
                        cgst,
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
                      FirebaseService().saveInvoice_GST(
                        _quotation_no,
                        _date,
                        _name,
                        _address,
                        _phonenumber,
                        _email,
                        _pan_id,
                        _gst_id,
                        _opt_id,
                        true,
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
                        sgst,
                        cgst,
                        0,
                        0,
                        totalAfterTax,
                        totalTax,
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
                  "Generate PDF",
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

  const PDFViewerScreen({
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

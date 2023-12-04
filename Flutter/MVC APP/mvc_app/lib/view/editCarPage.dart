import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mvc_app/model/carModel.dart';

class EditCarPage extends StatefulWidget {
  final String initialLob;
  final String initialModel;
  final String initialVariant;
  final double initialExShowroomPrice;
  final double initialRegistration;
  final double initialTempRegistration;
  final double initialOnRoadPrice;
  final double initialInsurance;
  final double initialHandlingServiceCharge;

  EditCarPage({
    required this.initialLob,
    required this.initialModel,
    required this.initialVariant,
    required this.initialExShowroomPrice,
    required this.initialRegistration,
    required this.initialTempRegistration,
    required this.initialOnRoadPrice,
    required this.initialInsurance,
    required this.initialHandlingServiceCharge,
  });
  @override
  _EditCarPageState createState() => _EditCarPageState();
}

class _EditCarPageState extends State<EditCarPage> {
  final _formKey = GlobalKey<FormState>();

  String _lob = '';
  String _model = '';
  String _variant = '';
  double _exShowroomPrice = 0;
  double _registration = 0;
  double _tempRegistration = 0;
  double _onRoadPrice = 0;
  double _insurance = 0;
  double _handlingServiceCharge = 0;

  late TextEditingController _lobController;
  late TextEditingController _modelController;
  late TextEditingController _variantController;
  late TextEditingController _exShowroomPriceController;
  late TextEditingController _registrationController;
  late TextEditingController _tempRegistrationController;
  late TextEditingController _onRoadPriceController;
  late TextEditingController _insuranceController;
  late TextEditingController _handlingServiceChargeController;

  @override
  void initState() {
    super.initState();

    _lobController = TextEditingController(text: widget.initialLob);
    _modelController = TextEditingController(text: widget.initialModel);
    _variantController = TextEditingController(text: widget.initialVariant);
    _exShowroomPriceController =
        TextEditingController(text: widget.initialExShowroomPrice.toString());
    _registrationController =
        TextEditingController(text: widget.initialRegistration.toString());
    _tempRegistrationController =
        TextEditingController(text: widget.initialTempRegistration.toString());
    _onRoadPriceController =
        TextEditingController(text: widget.initialOnRoadPrice.toString());
    _insuranceController =
        TextEditingController(text: widget.initialInsurance.toString());
    _handlingServiceChargeController = TextEditingController(
        text: widget.initialHandlingServiceCharge.toString());
  }

  @override
  void dispose() {
    _lobController.dispose();
    _modelController.dispose();
    _variantController.dispose();
    _exShowroomPriceController.dispose();
    _registrationController.dispose();
    _tempRegistrationController.dispose();
    _onRoadPriceController.dispose();
    _insuranceController.dispose();
    _handlingServiceChargeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Car'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _lobController,
                  decoration: InputDecoration(
                    labelText: 'LOB',
                  ),
                  onSaved: (value) => _lob = value!,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a LOB';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _modelController,
                  decoration: InputDecoration(
                    labelText: 'Model',
                  ),
                  onSaved: (value) => _model = value!,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a model';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _variantController,
                  decoration: InputDecoration(
                    labelText: 'Variant',
                  ),
                  onSaved: (value) => _variant = value!,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a variant';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _exShowroomPriceController,
                  decoration: InputDecoration(
                    labelText: 'Ex-ShowRoomPrice',
                  ),
                  keyboardType: TextInputType.number,
                  onSaved: (value) => _exShowroomPrice = double.parse(value!),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a variant';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _registrationController,
                  decoration: InputDecoration(
                    labelText: 'Registration',
                  ),
                  keyboardType: TextInputType.number,
                  onSaved: (value) => _registration = double.parse(value!),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a variant';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _tempRegistrationController,
                  decoration: InputDecoration(
                    labelText: 'Temp-Registration',
                  ),
                  keyboardType: TextInputType.number,
                  onSaved: (value) => _tempRegistration = double.parse(value!),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a variant';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _onRoadPriceController,
                  decoration: InputDecoration(
                    labelText: 'On-RoadPrice',
                  ),
                  keyboardType: TextInputType.number,
                  onSaved: (value) => _onRoadPrice = double.parse(value!),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a variant';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _insuranceController,
                  decoration: InputDecoration(
                    labelText: 'Insurance',
                  ),
                  keyboardType: TextInputType.number,
                  onSaved: (value) => _insurance = double.parse(value!),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a variant';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _handlingServiceChargeController,
                  decoration: InputDecoration(
                    labelText: 'HSRP',
                  ),
                  keyboardType: TextInputType.number,
                  onSaved: (value) =>
                      _handlingServiceCharge = double.parse(value!),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a variant';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 22,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      // Create a map with the updated car data
                      Map<String, dynamic> updatedData = {
                        'lob': _lob,
                        'model': _model,
                        'variant': _variant,
                        'exShowroomPrice': _exShowroomPrice,
                        'registration': _registration,
                        'tempRegistration': _tempRegistration,
                        'onRoadPrice': _onRoadPrice,
                        'insurance': _insurance,
                        'handlingServiceCharge': _handlingServiceCharge,
                      };

                      try {
                        // Query the car documents in Firestore based on the variant
                        QuerySnapshot querySnapshot = await FirebaseFirestore
                            .instance
                            .collection('cars')
                            .where('variant', isEqualTo: _variant)
                            .get();

                        if (querySnapshot.docs.isNotEmpty) {
                          // Get the first document from the query result
                          String documentId = querySnapshot.docs[0].id;

                          // Update the car document in Firestore
                          await FirebaseFirestore.instance
                              .collection('cars')
                              .doc(documentId)
                              .update(updatedData);

                          // Show a success message
                          setState(() {
                            _formKey.currentState!.reset();
                            _lobController.clear();
                            _modelController.clear();
                            _variantController.clear();
                            _exShowroomPriceController.clear();
                            _registrationController.clear();
                            _tempRegistrationController.clear();
                            _onRoadPriceController.clear();
                            _insuranceController.clear();
                            _handlingServiceChargeController.clear();
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Car updated successfully'),
                            ),
                          );
                          Navigator.pop(context);
                          // Optionally, you can navigate back to the previous screen or perform any other action after updating the car.
                          // Navigator.pop(context); // Uncomment this line if you want to navigate back after updating.
                        } else {
                          // Handle case when no document is found with the given variant
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'No car found with the variant: $_variant'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      } catch (error) {
                        // Show an error message if there's an issue updating the car
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Error updating car: $error'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }
                  },
                  child: Text('Update Car'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mvc_app/model/carModel.dart';

class AddCarPage extends StatefulWidget {
  @override
  _AddCarPageState createState() => _AddCarPageState();
}

class _AddCarPageState extends State<AddCarPage> {
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
  double _fleetedge = 0;
  double _amc = 0;
  double _cd = 0;
  double _captive = 0;
  double _loyalty = 0;
  double _welcome = 0;
  double _exchange = 0;
  double _mihtila_discount = 0;
  double _amc_canc = 0;
  int _gstPer = 0;

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Create a new Car object using the form data
      Car newCar = Car(
        lob: _lob,
        model: _model,
        vc_no: _variant,
        exShowroomPrice: _exShowroomPrice,
        registration: _registration,
        tempRegistration: _tempRegistration,
        onRoadPrice: _onRoadPrice,
        insurance: _insurance,
        handlingServiceCharge: _handlingServiceCharge,
        fleetedge: _fleetedge,
        amc: _amc,
        cd: _cd,
        captive: _captive,
        loyalty: _loyalty,
        welcome: _welcome,
        exchange: _exchange,
        mithila_discount: _mihtila_discount,
        amc_canc: _amc_canc,
        gstPer: _gstPer,
      );

      try {
        // Add the new car to Firestore
        await FirebaseFirestore.instance.collection('cars').add(newCar.toMap());

        // Show a success message
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Car added successfully'),
          ),
        );

        // Reset the form
        _formKey.currentState!.reset();
      } catch (error) {
        // Show an error message if there's an issue adding the car
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error adding car: $error'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
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
                const SizedBox(
                  height: 22,
                ),
                TextFormField(
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
                const SizedBox(
                  height: 22,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'VC Number',
                  ),
                  onSaved: (value) => _variant = value!,
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
                TextFormField(
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
                const SizedBox(
                  height: 22,
                ),
                TextFormField(
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
                const SizedBox(
                  height: 22,
                ),
                TextFormField(
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
                const SizedBox(
                  height: 22,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Basic',
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
                const SizedBox(
                  height: 22,
                ),
                TextFormField(
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
                const SizedBox(
                  height: 22,
                ),
                TextFormField(
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
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Fleetedge',
                  ),
                  keyboardType: TextInputType.number,
                  onSaved: (value) => _fleetedge = double.parse(value!),
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
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'AMC',
                  ),
                  keyboardType: TextInputType.number,
                  onSaved: (value) => _amc = double.parse(value!),
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
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'CD / NFA / UFD',
                  ),
                  keyboardType: TextInputType.number,
                  onSaved: (value) => _cd = double.parse(value!),
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
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Captive',
                  ),
                  keyboardType: TextInputType.number,
                  onSaved: (value) => _captive = double.parse(value!),
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
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Loyalty',
                  ),
                  keyboardType: TextInputType.number,
                  onSaved: (value) => _loyalty = double.parse(value!),
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
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Welcome',
                  ),
                  keyboardType: TextInputType.number,
                  onSaved: (value) => _welcome = double.parse(value!),
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
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Exchange',
                  ),
                  keyboardType: TextInputType.number,
                  onSaved: (value) => _exchange = double.parse(value!),
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
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Mithila Disc',
                  ),
                  keyboardType: TextInputType.number,
                  onSaved: (value) => _mihtila_discount = double.parse(value!),
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
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'AMC Canc',
                  ),
                  keyboardType: TextInputType.number,
                  onSaved: (value) => _amc_canc = double.parse(value!),
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
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'GST Percentage',
                  ),
                  keyboardType: TextInputType.number,
                  onSaved: (value) => _gstPer = int.parse(value!),
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
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _submitForm();
                    }
                  },
                  child: Text('Save Car'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

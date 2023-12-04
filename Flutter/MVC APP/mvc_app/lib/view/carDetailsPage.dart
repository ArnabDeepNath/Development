import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mvc_app/model/carModel.dart';
import 'package:mvc_app/view/editCarPage.dart';

class carDetailsPage extends StatefulWidget {
  @override
  _carDetailsPageState createState() => _carDetailsPageState();
}

class _carDetailsPageState extends State<carDetailsPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<String> lobs = [];
  List<String> models = [];
  String? selectedLob;
  String? selectedModel;
  List<Car> cars = [];

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      setState(() {});
    });
    getLobs();
  }

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
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Cars'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Lob:',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 10.0),
            DropdownButton<String>(
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
            SizedBox(height: 20.0),
            Text(
              'Select Model:',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 10.0),
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
            ListView.builder(
              shrinkWrap: true,
              itemCount: cars.length,
              itemBuilder: (context, index) {
                Car car = cars[index];
                return ListTile(
                  title: Text(car.vc_no),
                  subtitle: Text(car.model),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          // Handle edit button pressed for the car at the given index
                          // For example, navigate to an edit screen with the car details
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditCarPage(
                                initialLob: car.lob,
                                initialModel: car.model,
                                initialVariant: car.vc_no,
                                initialExShowroomPrice: car.exShowroomPrice,
                                initialRegistration: car.registration,
                                initialTempRegistration: car.tempRegistration,
                                initialOnRoadPrice: car.onRoadPrice,
                                initialHandlingServiceCharge:
                                    car.handlingServiceCharge,
                                initialInsurance: car.insurance,
                              ),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Confirm Delete'),
                                content: Text(
                                    'Are you sure you want to delete this car?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(
                                          context); // Close the dialog
                                    },
                                    child: Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        cars.removeAt(
                                            index); // Remove the car from the list
                                      });
                                      Navigator.pop(
                                          context); // Close the dialog
                                    },
                                    child: Text('Delete'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

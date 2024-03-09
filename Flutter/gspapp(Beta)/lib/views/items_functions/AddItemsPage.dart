import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gspappfinal/components/TextFormField.dart';
import 'package:gspappfinal/components/imagePicker.dart';
import 'package:gspappfinal/constants/AppColor.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:gspappfinal/models/ItemModel.dart';

class AddItemsPage extends StatefulWidget {
  const AddItemsPage({super.key});

  @override
  State<AddItemsPage> createState() => _AddItemsPageState();
}

class _AddItemsPageState extends State<AddItemsPage> {
  TextEditingController itemNameController = TextEditingController();
  TextEditingController itemCpuController = TextEditingController();
  TextEditingController itemUnitController = TextEditingController();
  TextEditingController itemDescController = TextEditingController();
  void clear() {
    itemNameController.clear();
    itemCpuController.clear();
    itemUnitController.clear();
    itemDescController.clear();
    setState(() {
      selectedImagePath = '';
    });
  }

  String? nonEmptyValidator(String? value) {
    if (value != null && value.isNotEmpty) {
      return null; // Field is not empty, so it's valid.
    }

    // Field is empty, so return an error message.
    return 'This field cannot be empty';
  }

  String? selectedImagePath;
  void _handleImageSelected(String imagePath) {
    setState(() {
      selectedImagePath = imagePath;
    });
  }

 Future<void> _postItemToSubcollection() async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final userId = user.uid;

        // Reference to the user's items subcollection
        final CollectionReference itemsCollection = FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('items');

        // Validate all fields
        if (_validateFields()) {
          String? imageUrl;

          // Upload image to Firebase Storage
          if (selectedImagePath != null) {
            final File imageFile = File(selectedImagePath!);
            final Reference storageReference = FirebaseStorage.instance.ref().child(
                'item_images/${userId}_${DateTime.now().millisecondsSinceEpoch}.jpg');
            final UploadTask uploadTask = storageReference.putFile(imageFile);
            TaskSnapshot taskSnapshot = await uploadTask;
            imageUrl = await storageReference.getDownloadURL();
          }

          // Add item details to the subcollection with auto-generated ID
          DocumentReference newItemRef = await itemsCollection.add({
            'itemName': itemNameController.text,
            'itemCpu': itemCpuController.text,
            'itemUnit': itemUnitController.text,
            'itemImage': imageUrl, // Store the download URL in Firestore
            'itemDescription': itemDescController.text,
            'creationDate': Timestamp.now(),
            // Add other item details as needed
            // ...
          });

          // Get the ID of the newly added item and update its ID field
          String newItemId = newItemRef.id;
          await newItemRef.update({'id': newItemId});

          // Display a success message or navigate to a different screen
          clear();
        }
      }
    } catch (e, stackTrace) {
      print('Error posting item: $e');
      print('Stack trace: $stackTrace');
      // Handle errors (show an error message, log, etc.)
    }
  }


  bool _validateFields() {
    if (itemNameController.text.isEmpty ||
        itemCpuController.text.isEmpty ||
        itemUnitController.text.isEmpty ||
        selectedImagePath == null ||
        itemDescController.text.isEmpty) {
      // Display an error message (you can customize this based on your UI)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('All fields must be filled.'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        title: Text(
          'New Item',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  TextFormFieldCustom(
                    label: 'Item Name',
                    controller: itemNameController,
                    onChange: (value) {},
                    validator: nonEmptyValidator,
                    obscureText: false,
                  ),
                  TextFormFieldCustom(
                    label: 'Item Cost Per Unit',
                    controller: itemCpuController,
                    onChange: (value) {},
                    validator: nonEmptyValidator,
                    obscureText: false,
                  ),
                  TextFormFieldCustom(
                    label: 'Item Unit',
                    controller: itemUnitController,
                    onChange: (value) {},
                    validator: nonEmptyValidator,
                    obscureText: false,
                  ),
                  CustomImagePicker(
                    onImageSelected: _handleImageSelected,
                  ),
                  TextFormFieldCustom(
                    label: 'Item Description',
                    controller: itemDescController,
                    onChange: (value) {},
                    validator: nonEmptyValidator,
                    obscureText: false,
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  _postItemToSubcollection();
                },
                child: Container(
                  height: 44,
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Center(
                    child: Text(
                      'Add Item',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(10),
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

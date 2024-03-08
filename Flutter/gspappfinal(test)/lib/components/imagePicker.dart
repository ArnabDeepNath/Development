import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';

class CustomImagePicker extends StatefulWidget {
  final void Function(String imagePath)? onImageSelected;

  const CustomImagePicker({Key? key, this.onImageSelected}) : super(key: key);

  @override
  _CustomImagePickerState createState() => _CustomImagePickerState();
}

class _CustomImagePickerState extends State<CustomImagePicker> {
  final ImagePicker _picker = ImagePicker();
  String? selectedImagePath;

  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          selectedImagePath = pickedFile.path;
        });
        widget.onImageSelected?.call(selectedImagePath!);
      }
    } catch (e) {
      // Handle image picking error
      print('Image picking error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: _pickImage,
          child: DottedBorder(
            dashPattern: [6, 3],
            color: Colors.blue,
            strokeWidth: 2,
            child: Container(
              height: 84,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Center(
                child: selectedImagePath != null
                    ? Image.file(
                        File(selectedImagePath!),
                        height: 80,
                        width: 80,
                        fit: BoxFit.cover,
                      )
                    : Text('Pick Image'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

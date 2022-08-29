// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProductImagePickerScreen extends StatefulWidget {

  // METHOD TO SEND IMAGE TO ADD PRODUCT SCREEN //
  
  final void Function(File pickedImage) getImageValue;
  ProductImagePickerScreen(this.getImageValue);

  @override
  State<ProductImagePickerScreen> createState() => _ProductImagePickerScreenState();
}

class _ProductImagePickerScreenState extends State<ProductImagePickerScreen> {
  
  // VAR USE FOR PICK IMAGE METHOD //
  var pickedImage;

  void imagePickerOption() {
    Get.bottomSheet(
      SingleChildScrollView(
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
          child: Container(
            color: Colors.white,
            height: 250,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Pick Image From",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      pickImage(ImageSource.camera);
                    },
                    icon: Icon(Icons.camera),
                    label: Text("Camera"),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      pickImage(ImageSource.gallery);
                    },
                    icon: Icon(Icons.image),
                    label: Text("Gallery"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(Icons.close),
                    label: Text("Cancel"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          width: 100,
          height: 100,
          child: pickedImage != null
              ? Image.file(
                  pickedImage!,
                  fit: BoxFit.cover,
                )
              : Image.network(
                  'https://static.thenounproject.com/png/2413564-200.png',
                  fit: BoxFit.cover,
                ),
        ),
        ElevatedButton.icon(
          onPressed: imagePickerOption,
          icon: Icon(Icons.image),
          label: Text('Add Image'),
        ),
      ],
    );
  }

  // PICK IMAGE FROM GALLERY OR CAMERA
  pickImage(ImageSource imageType) async {
    final ImagePicker _picker = ImagePicker();
    try {
      final photo = await _picker.pickImage(source: imageType);
      if (photo == null) return;
      final tempImage = File(photo.path);
      setState(() {
        this.pickedImage = tempImage;
        print(pickedImage);
        widget.getImageValue(pickedImage!);
      });
      // widget.getImageValue(pickedImage!);
      Get.back();
    } catch (error) {
      print(error);
    }
  }

}

// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_delivery_with_provider_using_firebase_app/screens/products/product_image_picker_screen.dart';
import 'package:food_delivery_with_provider_using_firebase_app/services/firebase_auth_method.dart';
import 'package:food_delivery_with_provider_using_firebase_app/services/product_provider.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {

  // CONTROLLER //
  TextEditingController productNameController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  // TextEditingController productImageController = TextEditingController();
  TextEditingController productCategoryController = TextEditingController();

  // FORM KEY TO VALIDATE FORM //
  final _formKey = GlobalKey<FormState>();
  // MAP FOR ACCESSING VAR TO SEND DATA IN DATABASE //
  // Map<String, dynamic> productData = {
  //   "productName": productNameController.text.toString(),
  //   "productPrice": "",
  //   "productCategory": ""
  // };

  var _userImageFile;
  // GET IMAGE IN ADD PRODUCT SCREEN FROM PRODUCT IMAGE PICKER SCREEN //
  void _pickedImage(File image) {
    _userImageFile = image;
   
   print('Image got from product image picker screen $_userImageFile');
  }


  @override
  Widget build(BuildContext context) {

    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    FirebaseAuthMethods firebaseAuthMethods = Provider.of<FirebaseAuthMethods>(context);

    // FUNCTION THAT WILL ADD DATA IN DATABASE //
  addProduct() {
    if(_userImageFile == null){
      Get.snackbar(
        "Oops", "Image required",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Theme.of(context).errorColor,
        colorText: Colors.white,
        margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
        );
        return;
    }

    _formKey.currentState!.save();
    if (_formKey.currentState!.validate()) {
      print("Form is valid ");

      print('Data for new product  ${productNameController.text.toString()}');

      productProvider.addNewProduct(
        productNameController.text.toString(),
        productPriceController.text.toString(),
        productCategoryController.text.toString(),
        firebaseAuthMethods.userId.toString(),
        _userImageFile,
      );
    }
  }

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Add New Product'),
      ),
      body: Card(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              children: [
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: productNameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Product Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Product Name Required';
                    }
                    return null;
                  },
                  // onSaved: (value) {
                  //   productData['p_name'] = value!;
                  // },
                ),
                TextFormField(
                  controller: productPriceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Product Price'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Product Price Required';
                    }
                    return null;
                  },
                  // onSaved: (value) {
                  //   productData['p_price'] = value!;
                  // },
                ),
                TextFormField(
                  controller: productCategoryController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: 'Category'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Product Category Required';
                    }
                    return null;
                  },
                  // onSaved: (value) {
                  //   productData['phone_number'] = value!;
                  // },
                ),
                SizedBox(
                  height: 30,
                ),
                ProductImagePickerScreen(_pickedImage),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: addProduct,
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_with_provider_using_firebase_app/controller/common_dialog.dart';
import 'package:food_delivery_with_provider_using_firebase_app/models/product_model.dart';
import 'package:food_delivery_with_provider_using_firebase_app/services/firebase_auth_method.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ProductProvider with ChangeNotifier {

  FirebaseAuthMethods firebaseAuthMethods = FirebaseAuthMethods();

  // GET USER DATA ON HOME SCREEN LOAD
  void onReady() {
    // _getHerbsProduct();
  }

  // ADD PRODUCT DATA IN DATABASE //
  Future<void> addNewProduct(productName, productPrice, productCategory, userid, File image) async {
    var pathimage = image.toString();
    var temp = pathimage.lastIndexOf('/');
    var result = pathimage.substring(temp + 1);
    print(result);
    // CommonDialog.showLoading();
    CommonDialog.showLoading();
    final ref =
        FirebaseStorage.instance.ref().child('productImages').child(result);
    var response = await ref.putFile(image);
    print("Updated $response");
    var imageUrl = await ref.getDownloadURL();
    print('Image url $imageUrl');

    try {
      CommonDialog.showLoading();
      var response = await FirebaseFirestore.instance.collection('productlist').add({
        'productName': productName,
        'productPrice': productPrice,
        'productImage': imageUrl,
        'productCategory': productCategory,
        'user_Id': userid,
      });
      notifyListeners();
      print("Firebase response $response");
      CommonDialog.hideLoading();
      Get.back();
      Get.snackbar(
        "Wow!",
        "New Product Added Successfully!",
        backgroundColor: Colors.teal,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.only(bottom: 10, left: 20, right: 10),
      );
    } catch (exception) {
      CommonDialog.hideLoading();
      print("Error Saving Data at firestore $exception");
    }
  }


  // CUSTOM PRODUCT MODEL FUNCTION
  customProductModel(QueryDocumentSnapshot element) {
    productModel = ProductModel(
          productId: element.id.toString(),
          productName: element.get('productName'), 
          productImage: element.get('productImage'), 
          productPrice: int.parse(element.get('productPrice')), 
          productCategory: element.get('productCategory'),
          productUnit: element.get('productUnit')
        );
  }


  // GET HERBS PRODUCT FROM DATABASE //
  List<ProductModel> allHerbsProduct = [];
  late ProductModel productModel;

  Future<void> getHerbsProduct() async {

    List<ProductModel> newList = [];
    
    QuerySnapshot value = await FirebaseFirestore.instance
      .collection('productlist')
      .where('productCategory', isEqualTo: 'Herbs')
      .get();

    value.docs.forEach(
      (element) {
        print(element.data());
        print('Product id => ${element.id}');

        customProductModel(element);
        
        newList.add(productModel);
       });

       allHerbsProduct = newList;
       notifyListeners();
  }

  List<ProductModel> get getHerbsProductList {
    return allHerbsProduct;
  }

  
  // GET FRUITS PRODUCT FROM DATABASE //
  List<ProductModel> allFruitsProduct = [];
  // late ProductModel fruitProductModel;

  Future<void> getFruitsProduct() async {

    List<ProductModel> newList = [];
    
    QuerySnapshot value = await FirebaseFirestore.instance
      .collection('productlist')
      .where('productCategory', isEqualTo: 'Fruits')
      .get();

    value.docs.forEach(
      (element) {
        print(element.data());

        customProductModel(element);
        
        newList.add(productModel);
       });

       allFruitsProduct = newList;
       notifyListeners();
  }

  List<ProductModel> get getFruitProductList {
    return allFruitsProduct;
  }


  // GET ALL PRODUCT FROM DATABASE //
  List<ProductModel> allProduct = [];
  // late ProductModel fruitProductModel;

  Future<void> getAllProduct() async {

    List<ProductModel> newList = [];
    
    QuerySnapshot value = await FirebaseFirestore.instance
      .collection('productlist')
      .get();

    value.docs.forEach(
      (element) {
        print(element.data());

        customProductModel(element);
        
        newList.add(productModel);
       });

       allProduct = newList;
       notifyListeners();
  }

  List<ProductModel> get getAllProductList {
    return allProduct;
  }


}
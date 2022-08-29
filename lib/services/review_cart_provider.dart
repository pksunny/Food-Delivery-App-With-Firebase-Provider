
// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_with_provider_using_firebase_app/controller/common_dialog.dart';
import 'package:food_delivery_with_provider_using_firebase_app/models/product_model.dart';
import 'package:food_delivery_with_provider_using_firebase_app/models/review_cart_model.dart';
import 'package:food_delivery_with_provider_using_firebase_app/services/firebase_auth_method.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ReviewCartProvider with ChangeNotifier {

  FirebaseAuthMethods firebaseAuthMethods = FirebaseAuthMethods();


  // ADD REVIEW CART DATA IN DATABASE //
  Future<void> addReviewCartData(cartId, cartName, cartImage, cartPrice, cartCategory, cartQuantity, cartUnit, userId) async {

    try {
      CommonDialog.showLoading();
      var response = await FirebaseFirestore.instance
      .collection('reviewcartlist')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("yourcartlist")
      .doc(cartId)
      .set({
        'cartId': cartId,
        'cartName': cartName,
        'cartImage': cartImage,
        'cartPrice': cartPrice,
        'cartCategory': cartCategory,
        'cartQuantity': cartQuantity,
        'cartUnit': cartUnit,
        'userId': userId,
        'isAdd': true,
      });
      // notifyListeners();
      // print("Firebase response $response");
      CommonDialog.hideLoading();
      // Get.back();
      Get.snackbar(
        "Wow!",
        "New Cart Review Added Successfully!",
        backgroundColor: Colors.teal,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.only(bottom: 10, left: 20, right: 10),
      );
    } catch (exception) {
      CommonDialog.hideLoading();
      print("Error Saving Data at firestore $exception");
    }
  }


  // CUSTOM REVIEW CART MODEL FUNCTION
  // customReviewCartModel(QueryDocumentSnapshot element) {
  //   ReviewCartModel reviewCartModel = ReviewCartModel(
  //         cartId: element.get('cartId'),
  //         cartName: element.get('cartName'), 
  //         cartImage: element.get('cartImage'), 
  //         cartPrice: int.parse(element.get('cartPrice')), 
  //         cartCategory: element.get('cartCategory'),
  //         cartQuantity: element.get('cartQuantity'),
  //         userid: element.get('userId'),
  //         isAdd: element.get('isAdd'),
  //       );
  // }


  // GET REVIEW CART PRODUCT FROM DATABASE //
  List<ReviewCartModel> yourCartList = [];

  Future<void> getYourCartProduct() async {

    List<ReviewCartModel> newList = [];
    
    QuerySnapshot value = await FirebaseFirestore.instance
      .collection('reviewcartlist')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('yourcartlist')
      .get();

    value.docs.forEach(
      (element) {
        print(element.data());
        print('Cart id => ${element.id}');

        ReviewCartModel reviewCartModel = ReviewCartModel(
          cartId: element.get('cartId'),
          cartName: element.get('cartName'), 
          cartImage: element.get('cartImage'), 
          cartPrice: element.get('cartPrice'), 
          cartCategory: element.get('cartCategory'),
          cartQuantity: element.get('cartQuantity'),
          cartUnit: element.get('cartUnit'),
          userid: element.get('userId'),
          isAdd: element.get('isAdd'),
        );
        
        newList.add(reviewCartModel);
       });

       yourCartList = newList;
       notifyListeners();
  }

  List<ReviewCartModel> get getYourCartList {
    return yourCartList;
  }


  // GET TOTAL PRICE IN REVIEW CART 
  getTotalPrice(){

    double total = 0.0;

    yourCartList.forEach((element) { 

      total += element.cartPrice * element.cartQuantity;
    });
    return total;
  }


  // DELETE REVIEW CART DATA FROM DATABASE
  Future deleteReviewCartProduct(cartId) async {
    print("Product Iddd  $cartId");
    try {
      CommonDialog.showLoading();
      await FirebaseFirestore.instance
          .collection("reviewcartlist")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("yourcartlist")
          .doc(cartId)
          .delete()
          .then((_) {
        CommonDialog.hideLoading();
        getYourCartProduct();
        notifyListeners();
        Get.snackbar(
          'Wow!', 
          'Product deleted successfully!',
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        );
      });
    } catch (error) {
      CommonDialog.hideLoading();
      CommonDialog.showErrorDialog();
      print(error);
    }
  }

  // UPDATE REVIEW CART DATA IN DATABASE //
  Future<void> updateReviewCartData(cartId, cartName, cartImage, cartPrice, cartCategory, cartQuantity, userId) async {

    try {
      CommonDialog.showLoading();
      var response = await FirebaseFirestore.instance
      .collection('reviewcartlist')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("yourcartlist")
      .doc(cartId)
      .update({
        'cartId': cartId,
        'cartName': cartName,
        'cartImage': cartImage,
        'cartPrice': cartPrice,
        'cartCategory': cartCategory,
        'cartQuantity': cartQuantity,
        'userId': userId,
        'isAdd': true,
      });
      // notifyListeners();
      // print("Firebase response $response");
      CommonDialog.hideLoading();
      // Get.back();
      Get.snackbar(
        "Wow!",
        "Cart quantity updated successfully!",
        backgroundColor: Colors.teal,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.only(bottom: 10, left: 20, right: 10),
      );
    } catch (exception) {
      CommonDialog.hideLoading();
      print("Error Saving Data at firestore $exception");
    }
  }

}
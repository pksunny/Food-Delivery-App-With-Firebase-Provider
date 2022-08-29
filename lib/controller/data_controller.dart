// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_with_provider_using_firebase_app/controller/auth_controller.dart';
import 'package:food_delivery_with_provider_using_firebase_app/controller/common_dialog.dart';
import 'package:get/get.dart';

class DataController extends ChangeNotifier {
  final firebaseInstance = FirebaseFirestore.instance;
  Map userProfileData = {'userName': '', 'joinDate': ''};

  AuthController authController = Get.find();

  // GET USER DATA ON HOME SCREEN LOAD
  void onReady() {
    // super.onReady();
    // getAllProduct();
    getUserProfileData();
  }

  // GET USER DATA
  Future<void> getUserProfileData() async {
    // print("user id ${authController.userId}");
    try {
      var response = await firebaseInstance
          .collection('userslist')
          .where('user_Id', isEqualTo: authController.userId)
          .get();
      // response.docs.forEach((result) {
      //   print(result.data());
      // });
      if (response.docs.length > 0) {
        userProfileData['userName'] = response.docs[0]['user_name'];
        userProfileData['joinDate'] = response.docs[0]['joinDate'];
      }
      print(userProfileData);
    } on FirebaseException catch (e) {
      print(e);
    } catch (error) {
      print(error);
    }
  }

  // ADD PRODUCT DATA IN DATABASE //
  Future<void> addNewProduct(Map productdata, File image) async {
    var pathimage = image.toString();
    var temp = pathimage.lastIndexOf('/');
    var result = pathimage.substring(temp + 1);
    print(result);
    // CommonDialog.showLoading();
    CommonDialog.showLoading();
    final ref =
        FirebaseStorage.instance.ref().child('product_images').child(result);
    var response = await ref.putFile(image);
    print("Updated $response");
    var imageUrl = await ref.getDownloadURL();
    print('Image url $imageUrl');

    try {
      CommonDialog.showLoading();
      var response = await firebaseInstance.collection('productlist').add({
        'product_name': productdata['p_name'],
        'product_price': productdata['p_price'],
        "product_upload_date": productdata['p_upload_date'],
        'product_image': imageUrl,
        'user_Id': authController.userId,
        "phone_number": productdata['phone_number'],
      });
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

  // GET LOGIN USER PRODUCT FROM DATABASE //
  // List<Product> loginUserData = [];

  // Future<void> getLoginUserProduct() async {
  //   print("loginUserData YEs $loginUserData");
  //   loginUserData = [];
  //   try {
  //     CommonDialog.showLoading();
  //     final List<Product> lodadedProduct = [];
  //     var response = await firebaseInstance
  //         .collection('productlist')
  //         .where('user_Id', isEqualTo: authController.userId)
  //         .get();

  //     if (response.docs.length > 0) {
  //       response.docs.forEach(
  //         (result) {
  //           print(result.data());
  //           print("Product ID  ${result.id}");
  //           lodadedProduct.add(
  //             Product(
  //                 productId: result.id,
  //                 userId: result['user_Id'],
  //                 productname: result['product_name'],
  //                 productprice: double.parse(result['product_price'].toString()),
  //                 productimage: result['product_image'],
  //                 phonenumber: int.parse(result['phone_number']),
  //                 productuploaddate: result['product_upload_date'].toString()),
  //           );
  //         },
  //       );
  //     }
  //     loginUserData.addAll(lodadedProduct);
  //     update();
  //     CommonDialog.hideLoading();
  //   } on FirebaseException catch (e) {
  //     CommonDialog.hideLoading();
  //     print("Error $e");
  //   } catch (error) {
  //     CommonDialog.hideLoading();
  //     print("error $error");
  //   }
  // }

  // GET ALL PRODUCT FROM DATABASE //
  // List<Product> allProduct = [];

  // Future<void> getAllProduct() async {
  //   allProduct = [];
  //   try {
  //     CommonDialog.showLoading();
  //     final List<Product> lodadedProduct1 = [];
  //     var response = await firebaseInstance
  //         .collection('productlist')
  //         .where('user_Id', isNotEqualTo: authController.userId)
  //         .get();
  //     if (response.docs.length > 0) {
  //       response.docs.forEach(
  //         (result) {
  //           print(result.data());
  //           print(result.id);
  //           lodadedProduct1.add(
  //             Product(
  //                 productId: result.id,
  //                 userId: result['user_Id'],
  //                 productname: result['product_name'],
  //                 productprice: double.parse(result['product_price'].toString()),
  //                 productimage: result['product_image'],
  //                 phonenumber: int.parse(result['phone_number']),
  //                 productuploaddate: result['product_upload_date'].toString()),
  //           );
  //         },
  //       );
  //       allProduct.addAll(lodadedProduct1);
  //       update();
  //     }

  //     CommonDialog.hideLoading();
  //   } on FirebaseException catch (e) {
  //     CommonDialog.hideLoading();
  //     print("Error $e");
  //   } catch (error) {
  //     CommonDialog.hideLoading();
  //     print("error $error");
  //   }
  // }

  // EDIT PRODUCT DATA FROM DATABASE //
  // Future editProduct(productId, price) async {
  //   print("Product Id  $productId");
  //   try {
  //     CommonDialog.showLoading();
  //     await firebaseInstance
  //         .collection("productlist")
  //         .doc(productId)
  //         .update({"product_price": price}).then((_) {
  //       CommonDialog.hideLoading();
  //       getLoginUserProduct();
  //     });
  //   } catch (error) {
  //     CommonDialog.hideLoading();
  //     CommonDialog.showErrorDialog();

  //     print(error);
  //   }
  // }

  // DELETE PRODUCT DATA FROM DATABASE
  // Future deleteProduct(String productId) async {
  //   print("Product Iddd  $productId");
  //   try {
  //     CommonDialog.showLoading();
  //     await firebaseInstance
  //         .collection("productlist")
  //         .doc(productId)
  //         .delete()
  //         .then((_) {
  //       CommonDialog.hideLoading();
  //       getLoginUserProduct();
  //     });
  //   } catch (error) {
  //     CommonDialog.hideLoading();
  //     CommonDialog.showErrorDialog();
  //     print(error);
  //   }
  // }
}

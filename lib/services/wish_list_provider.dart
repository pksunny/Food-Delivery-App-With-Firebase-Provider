
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_with_provider_using_firebase_app/controller/common_dialog.dart';
import 'package:food_delivery_with_provider_using_firebase_app/models/review_cart_model.dart';
import 'package:food_delivery_with_provider_using_firebase_app/models/wish_list_model.dart';
import 'package:food_delivery_with_provider_using_firebase_app/services/firebase_auth_method.dart';
import 'package:get/get.dart';

class WishListProvider with ChangeNotifier {

  FirebaseAuthMethods firebaseAuthMethods = FirebaseAuthMethods();


  // ADD WISHLIST DATA IN DATABASE //
  Future<void> addWishListData(wishListId, wishListName, wishListImage, wishListPrice, wishListCategory, wishListQuantity, userId) async {

    try {
      CommonDialog.showLoading();
      var response = await FirebaseFirestore.instance
      .collection('wishlist')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("yourwishlist")
      .doc(wishListId)
      .set({
        'wishListId': wishListId,
        'wishListName': wishListName,
        'wishListImage': wishListImage,
        'wishListPrice': wishListPrice,
        'wishListCategory': wishListCategory,
        'wishListQuantity': wishListQuantity,
        'userId': userId,
        'wishList': true,
      });
      // notifyListeners();
      // print("Firebase response $response");
      CommonDialog.hideLoading();
      // Get.back();
      Get.snackbar(
        "Wow!",
        "This product added to your wishlist!",
        backgroundColor: Colors.teal,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.only(bottom: 10, left: 20, right: 10),
      );
    } catch (exception) {
      CommonDialog.hideLoading();
      print("Error Saving Data at firestore $exception");
    }
  }


  // CUSTOM WISHLIST MODEL FUNCTION
  // customReviewCartModel(QueryDocumentSnapshot element) {
  //   WishListModel reviewCartModel = WishListModel(
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


  // GET WISHLIST DATA FROM DATABASE //
  List<WishListModel> yourWishList = [];

  Future<void> getWishListData() async {

    List<WishListModel> newList = [];
    
    QuerySnapshot value = await FirebaseFirestore.instance
      .collection('wishlist')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('yourwishlist')
      .get();

    value.docs.forEach(
      (element) {
        print(element.data());
        print('wish list id => ${element.id}');

        WishListModel wishListModel = WishListModel(
          wishListId: element.get('wishListId'),
          wishListName: element.get('wishListName'), 
          wishListImage: element.get('wishListImage'), 
          wishListPrice: element.get('wishListPrice'), 
          wishListCategory: element.get('wishListCategory'),
          wishListQuantity: element.get('wishListQuantity'),
          userid: element.get('userId'),
          wishList: element.get('wishList'),
        );
        
        newList.add(wishListModel);
       });

       yourWishList = newList;
       notifyListeners();
  }

  List<WishListModel> get getYourWishList {
    return yourWishList;
  }


  // DELETE WISHLIST DATA FROM DATABASE
  Future deleteWishListData(wishListId) async {
    print("Product Iddd  $wishListId");
    try {
      CommonDialog.showLoading();
      await FirebaseFirestore.instance
          .collection("wishlist")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("yourwishlist")
          .doc(wishListId)
          .delete()
          .then((_) {
        CommonDialog.hideLoading();
        getWishListData();
        notifyListeners();
        Get.snackbar(
          'Wow!', 
          'Wish list removed successfully!',
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

  // UPDATE WISHLIST DATA IN DATABASE //
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
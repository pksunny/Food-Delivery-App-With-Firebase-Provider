// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_with_provider_using_firebase_app/models/product_model.dart';
import 'package:food_delivery_with_provider_using_firebase_app/screens/review/review_cart.dart';
import 'package:food_delivery_with_provider_using_firebase_app/services/firebase_auth_method.dart';
import 'package:food_delivery_with_provider_using_firebase_app/services/review_cart_provider.dart';
import 'package:food_delivery_with_provider_using_firebase_app/utils/screen_size.dart';
import 'package:food_delivery_with_provider_using_firebase_app/utils/text_stylz.dart';
import 'package:provider/provider.dart';

class CustomQuantityButton extends StatefulWidget {
  CustomQuantityButton({
    super.key,
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.productCategory,
    required this.productPrice,
    required this.productQuantity,
    this.productUnit
  });

  String productId;
  String productName;
  String productImage;
  String productCategory;
  int productPrice;
  int productQuantity;
  var productUnit;

  @override
  State<CustomQuantityButton> createState() => _CustomQuantityButtonState();
}

class _CustomQuantityButtonState extends State<CustomQuantityButton> {

  int count = 1;

  bool isTrue = false;

  getAddAndQuantity(){
    FirebaseFirestore.instance
      .collection('reviewcartlist')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('yourcartlist')
      .doc(widget.productId)
      .get()
      .then((value) => {

        if(this.mounted){
          if(value.exists){
            setState(() {
              count = value.get('cartQuantity');
              isTrue = value.get('isAdd');
            })
          }
        }

        });
  }

  @override
  Widget build(BuildContext context) {

    getAddAndQuantity();

    ReviewCartProvider reviewCartProvider = Provider.of(context);
    FirebaseAuthMethods firebaseAuthMethods = Provider.of(context);

    // print('${widget.productId} , ${widget.productName} , ${widget.productCategory}');

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: ScreenSize(context).width * 0.20,
      height: ScreenSize(context).height * 0.05,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          // color: Colors.teal,
          border: Border.all(color: Colors.teal)),
      child: isTrue == true ? Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: (){

              if(count == 1){
                setState(() {
                  isTrue = false;
                });

                // ON PRESS OF MINUS DELETE THE PRODUCT IF LESS THAN 1
                reviewCartProvider.deleteReviewCartProduct(widget.productId);
              } else if(count > 1) {
                setState(() {
                  count--;
                });

                // UPDATE QUANTITY WHEN DEC COUNT IS PRESSED
                reviewCartProvider.updateReviewCartData(
                  widget.productId,
                  widget.productName, 
                  widget.productImage, 
                  widget.productPrice, 
                  widget.productCategory,
                  count, 
                  firebaseAuthMethods.userId,
                );

              }
            },
            child: Icon(
              Icons.remove,
              color: Colors.teal,
            ),
          ),
          Text(
            '${count}',
            style: TextStylz.herbQuantity,
          ),
          InkWell(
            onTap: (){
              setState(() {
                count++;
              });

              // UPDATE QUANTITY WHEN INC COUNT IS PRESSED
              reviewCartProvider.updateReviewCartData(
                widget.productId,
                widget.productName, 
                widget.productImage, 
                widget.productPrice, 
                widget.productCategory,
                count, 
                firebaseAuthMethods.userId,
              );
            },
            child: Icon(
              Icons.add,
              color: Colors.teal,
            ),
          ),
        ],
      ) : Center(
        child: InkWell(
          onTap: (){
            setState(() {
              isTrue = true;
            });

            reviewCartProvider.addReviewCartData(
              widget.productId,
              widget.productName, 
              widget.productImage, 
              widget.productPrice, 
              widget.productCategory,
              count,
              widget.productUnit, 
              firebaseAuthMethods.userId,
            );


          },
          child: Text('Add', style: TextStylz.drawerLoginName.copyWith(color: Colors.black54),),
        ),
      )
    );
  }
}

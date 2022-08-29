// ignore_for_file: prefer_const_constructors

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:food_delivery_with_provider_using_firebase_app/services/review_cart_provider.dart';
import 'package:food_delivery_with_provider_using_firebase_app/utils/screen_size.dart';
import 'package:food_delivery_with_provider_using_firebase_app/utils/text_stylz.dart';
import 'package:food_delivery_with_provider_using_firebase_app/widgets/custom_icon_button.dart';
import 'package:food_delivery_with_provider_using_firebase_app/widgets/custom_icon_text_button.dart';
import 'package:food_delivery_with_provider_using_firebase_app/widgets/custom_quantity_button.dart';
import 'package:provider/provider.dart';

class ReviewCartData extends StatefulWidget {
  ReviewCartData({
    super.key,
    required this.cartId,
    required this.cartName,
    required this.cartImage,
    required this.cartPrice,
    required this.cartCategory,
    required this.cartQuantity,
    this.cartUnit,
    required this.onDelete,
  });

  String cartId;
  String cartName;
  String cartImage;
  int cartPrice;
  String cartCategory;
  int cartQuantity;
  var cartUnit;

  VoidCallback onDelete;

  @override
  State<ReviewCartData> createState() => _ReviewCartDataState();
}

class _ReviewCartDataState extends State<ReviewCartData> {

  int? count;

  getCount(){
    setState(() {
      count = widget.cartQuantity;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCount();
  }

  @override
  Widget build(BuildContext context) {
    
    ReviewCartProvider reviewCartProvider = Provider.of(context);
    // reviewCartProvider.getYourCartProduct();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: ScreenSize(context).height * 0.15,
              child: Center(
                child: Image.network(widget.cartImage),
              ),
            ),
          ),
          Expanded(
            child: Container(
                height: ScreenSize(context).height * 0.15,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.cartName,
                          style: TextStylz.herbsName,
                        ),
                        Text(
                          '${widget.cartPrice}\$/50 Gram',
                          style: TextStylz.herbsName,
                        ),

                        SizedBox(height: 15,),
                        Text(
                          '${widget.cartUnit}',
                          style: TextStylz.herbsName,
                        ),
                      ],
                    ),
                    
                  ],
                )),
          ),
          Expanded(
            child: Container(
              height: ScreenSize(context).height * 0.15,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // CUSTOM ICON BUTTON
                    CustomIconButton(
                      onPressed: widget.onDelete,
                      icon: Icons.delete_outline,
                      color: Colors.red,
                    ),

                    // CUSTOM QUANTITY BUTTON
                    CustomQuantityButton(
                      productId: widget.cartId, 
                      productName: widget.cartName, 
                      productImage: widget.cartImage, 
                      productCategory: widget.cartCategory, 
                      productPrice: widget.cartPrice, 
                      productQuantity: widget.cartQuantity,
                      productUnit: widget.cartUnit,
                    )
                    
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

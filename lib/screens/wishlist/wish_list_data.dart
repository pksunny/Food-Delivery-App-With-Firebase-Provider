// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:food_delivery_with_provider_using_firebase_app/utils/screen_size.dart';
import 'package:food_delivery_with_provider_using_firebase_app/utils/text_stylz.dart';
import 'package:food_delivery_with_provider_using_firebase_app/widgets/custom_icon_button.dart';
import 'package:food_delivery_with_provider_using_firebase_app/widgets/custom_icon_text_button.dart';
import 'package:food_delivery_with_provider_using_firebase_app/widgets/custom_quantity_button.dart';

class WishListData extends StatefulWidget {
  WishListData({
    super.key,
    required this.cartId,
    required this.cartName,
    required this.cartImage,
    required this.cartPrice,
    required this.cartCategory,
    required this.cartQuantity,
    required this.onDelete,
  });

  String cartId;
  String cartName;
  String cartImage;
  int cartPrice;
  String cartCategory;
  int cartQuantity;

  VoidCallback onDelete;

  @override
  State<WishListData> createState() => _WishListDataState();
}

class _WishListDataState extends State<WishListData> {
  @override
  Widget build(BuildContext context) {
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
                          '${widget.cartQuantity} Gram',
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
              // color: Colors.yellow,
              child: CustomIconButton(
                    onPressed: widget.onDelete,
                    icon: Icons.delete_outline,
                    color: Colors.red,
                    iconSize: 45,
                  ),
              ),
            ),
        ]
      ),
    );
  }
}

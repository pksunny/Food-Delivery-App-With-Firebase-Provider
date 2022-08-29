// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:food_delivery_with_provider_using_firebase_app/models/review_cart_model.dart';
import 'package:food_delivery_with_provider_using_firebase_app/utils/text_stylz.dart';
import 'package:provider/provider.dart';

class OrderData extends StatelessWidget {
  OrderData({super.key, this.isTrue, required this.reviewCartModel  });

  bool? isTrue = false;

  final ReviewCartModel reviewCartModel;

  @override
  Widget build(BuildContext context) {

    return ListTile(
      leading: Image.network(reviewCartModel.cartImage,
        width: 60,
      ),

      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Text(reviewCartModel.cartName, style: TextStylz.herbsGram,),

          Text(reviewCartModel.cartUnit, style: TextStylz.herbsGram,),

          Text('${reviewCartModel.cartPrice}\$', style: TextStylz.herbsGram,),
        ],
      ),

      subtitle: Text(reviewCartModel.cartQuantity.toString()),
      
    );
  }
}
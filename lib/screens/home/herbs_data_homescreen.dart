// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:food_delivery_with_provider_using_firebase_app/models/product_model.dart';
import 'package:food_delivery_with_provider_using_firebase_app/screens/home/product_unit.dart';
import 'package:food_delivery_with_provider_using_firebase_app/utils/screen_size.dart';
import 'package:food_delivery_with_provider_using_firebase_app/utils/text_stylz.dart';
import 'package:food_delivery_with_provider_using_firebase_app/widgets/custom_quantity_button.dart';
import 'package:get/get.dart';

class HerbsDataHomeScreen extends StatefulWidget {
  HerbsDataHomeScreen({
    super.key,
    required this.herbsId,
    required this.herbsName,
    required this.herbsPrice,
    required this.herbsImage,
    required this.productCategory,
    required this.productModel,
    required this.onTap,
  });

  String herbsId;
  String herbsName;
  String herbsPrice;
  String herbsImage;
  String productCategory;
  final ProductModel productModel;
  void Function() onTap;

  @override
  State<HerbsDataHomeScreen> createState() => _HerbsDataHomeScreenState();
}

class _HerbsDataHomeScreenState extends State<HerbsDataHomeScreen> {

  // FOR GET MODAL SHEET GRAM FROM DATABASE
  var unitData;
  var firstValue;

  
  @override
  Widget build(BuildContext context) {

    // FOR GETTING MODAL SHEET DATA
    widget.productModel.productUnit.firstWhere((element) {
      setState(() {
        firstValue = element;
      });
      return true;
    });

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        width: ScreenSize(context).width * 0.65,
        height: ScreenSize(context).height * 0.40,
        child: InkWell(
          onTap: widget.onTap,
          child: Card(
            // elevation: 15,
            // shadowColor: Colors.teal,
            color: Colors.grey.shade100,
              
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: ScreenSize(context).width * 0.55,
                    height: ScreenSize(context).height * 0.22,
                    child: Image.network(widget.herbsImage, fit: BoxFit.contain,)),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.herbsName, style: TextStylz.herbsName),
                      SizedBox(
                        height: ScreenSize(context).height * 0.002,
                      ),
                      Text("${widget.herbsPrice}\$/${unitData == null ? " $firstValue" : " $unitData"}", style: TextStylz.herbsGram),
                    ],
                  ),
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                     // CUSTOM PRODUCT UNIT
                  ProductUnit(
                      title: unitData == null ? ' $firstValue' : ' $unitData',
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: widget.productModel.productUnit.map((e) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                        child: InkWell(
                                          onTap: (){

                                            setState(() {
                                              unitData = e;
                                            });

                                            Get.back();
                                          },
                                          child: Text(e, style: TextStylz.herbsGram,),
                                        ),
                                      )
                                    ],
                                  );
                                }).toList(),
                              );
                            }
                        );
                      }),
                    // CUSTOM QUNATITY BUTTON
                    CustomQuantityButton(
                      productId: widget.herbsId,
                      productName: widget.herbsName,
                      productImage: widget.herbsImage,
                      productCategory: widget.productCategory,
                      productPrice: int.parse(widget.herbsPrice),
                      productQuantity: 1,
                      productUnit: unitData == null ? ' $firstValue' : ' $unitData',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
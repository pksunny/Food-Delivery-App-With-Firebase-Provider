// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:food_delivery_with_provider_using_firebase_app/screens/home/product_unit.dart';
import 'package:food_delivery_with_provider_using_firebase_app/utils/screen_size.dart';
import 'package:food_delivery_with_provider_using_firebase_app/utils/text_stylz.dart';
import 'package:food_delivery_with_provider_using_firebase_app/widgets/custom_quantity_button.dart';
import 'package:get/get.dart';

import '../../models/product_model.dart';

class FruitsDataHomeScreen extends StatefulWidget {
  FruitsDataHomeScreen(
      {super.key,
      required this.fruitId,
      required this.fruitName,
      required this.fruitPrice,
      required this.fruitImage,
      required this.productCategory,
      required this.productModel,
      required this.onTap,});

  String fruitId;
  String fruitName;
  String fruitPrice;
  String fruitImage;
  String productCategory;
  final ProductModel productModel;
  void Function() onTap;

  @override
  State<FruitsDataHomeScreen> createState() => _FruitsDataHomeScreenState();
}

class _FruitsDataHomeScreenState extends State<FruitsDataHomeScreen> {

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


    return Container(
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
                  child: Image.network(widget.fruitImage)
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.fruitName, style: TextStylz.herbsName),
                    SizedBox(
                      height: ScreenSize(context).height * 0.002,
                    ),
                    Text("${widget.fruitPrice}\$/${unitData == null ? " $firstValue" : " $unitData"}",
                        style: TextStylz.herbsGram),
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
                  // CUSTOM QUNATITY BUTTON
                  CustomQuantityButton(
                    productId: widget.fruitId,
                    productName: widget.fruitName,
                    productImage: widget.fruitImage,
                    productCategory: widget.productCategory,
                    productPrice: int.parse(widget.fruitPrice),
                    productQuantity: 1,
                    productUnit: unitData == null ? ' $firstValue' : ' $unitData',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

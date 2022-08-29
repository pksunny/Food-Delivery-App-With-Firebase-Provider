// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:food_delivery_with_provider_using_firebase_app/utils/screen_size.dart';
import 'package:food_delivery_with_provider_using_firebase_app/utils/text_stylz.dart';
import 'package:food_delivery_with_provider_using_firebase_app/widgets/custom_icon_text_button.dart';
import 'package:food_delivery_with_provider_using_firebase_app/widgets/custom_quantity_button.dart';

class SearchItems extends StatefulWidget {
  SearchItems(
      {super.key,
      required this.productId,
      required this.productName,
      required this.productPrice,
      required this.productImage,
      required this.productCategory});

  String productId;
  String productName;
  int productPrice;
  String productImage;
  String productCategory;

  @override
  State<SearchItems> createState() => _SearchItemsState();
}

class _SearchItemsState extends State<SearchItems> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: ScreenSize(context).height * 0.15,
              child: Center(child: Image.network(widget.productImage)),
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
                          widget.productName,
                          style: TextStylz.herbsName,
                        ),
                        Text(
                          '${widget.productPrice}\$/50 Gram',
                          style: TextStylz.GramChange,
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        // showModalBottomSheet(
                        //     context: context,
                        //     builder: (context) {
                        //       return Column(
                        //         mainAxisSize: MainAxisSize.min,
                        //         children: <Widget>[
                        //           ListTile(
                        //             title: new Text('50 Gram'),
                        //             onTap: () {
                        //               Navigator.pop(context);
                        //             },
                        //           ),
                        //           ListTile(
                        //             title: new Text('500 Gram'),
                        //             onTap: () {
                        //               Navigator.pop(context);
                        //             },
                        //           ),
                        //           ListTile(
                        //             title: new Text('1 Kg'),
                        //             onTap: () {
                        //               Navigator.pop(context);
                        //             },
                        //           ),
                        //         ],
                        //       );
                        //     });
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 10),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        height: ScreenSize(context).height * 0.05,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 2, color: Colors.teal)),
                        child: Row(
                          children: [
                            Text(
                              '50 Gram',
                              style: TextStylz.herbsGram.copyWith(fontSize: 16),
                            ),
                            Icon(
                              Icons.arrow_drop_down_rounded,
                              color: Colors.teal,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          ),

          // CUSTOM QUANTITY BUTTON
          CustomQuantityButton(
            productId: widget.productId,
            productName: widget.productName,
            productImage: widget.productImage,
            productCategory: widget.productCategory,
            productPrice: widget.productPrice,
            productQuantity: 1,
          ),
        ],
      ),
    );
  }
}

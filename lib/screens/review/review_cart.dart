// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:food_delivery_with_provider_using_firebase_app/controller/common_dialog.dart';
import 'package:food_delivery_with_provider_using_firebase_app/screens/delivery/delivery%20details/delivery_details.dart';
import 'package:food_delivery_with_provider_using_firebase_app/screens/review/review_cart_data.dart';
import 'package:food_delivery_with_provider_using_firebase_app/services/review_cart_provider.dart';
import 'package:food_delivery_with_provider_using_firebase_app/utils/screen_size.dart';
import 'package:food_delivery_with_provider_using_firebase_app/utils/text_stylz.dart';
import 'package:food_delivery_with_provider_using_firebase_app/widgets/custom_alert_dialog.dart';
import 'package:food_delivery_with_provider_using_firebase_app/widgets/custom_bottom_navbar.dart';
import 'package:food_delivery_with_provider_using_firebase_app/widgets/custom_divider.dart';
import 'package:food_delivery_with_provider_using_firebase_app/widgets/custom_icon_button.dart';
import 'package:food_delivery_with_provider_using_firebase_app/widgets/custom_icon_text_button.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ReviewCart extends StatefulWidget {
  ReviewCart({super.key});

  @override
  State<ReviewCart> createState() => _ReviewCartState();
}

class _ReviewCartState extends State<ReviewCart> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ReviewCartProvider reviewCartProvider = Provider.of(context, listen: false);
    reviewCartProvider.getYourCartProduct();
  }

  @override
  Widget build(BuildContext context) {
    ReviewCartProvider reviewCartProvider = Provider.of(context);
    // print(reviewCartProvider.yourCartList);

    return Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Text('Review Cart'),
          centerTitle: true,
        ),

        // CUSTOM BOTTOM NAV BAR
        bottomNavigationBar: Row(
          children: [
            CustomBottomNavbar(
              iconColor: Colors.white,
              backgroundColor: Colors.teal.shade400,
              color: Colors.white,
              title: 'Total: ${reviewCartProvider.getTotalPrice()}',
              icon: Icons.attach_money_rounded,
              onTap: () {},
            ),
            CustomBottomNavbar(
              iconColor: Colors.white,
              backgroundColor: Colors.teal,
              color: Colors.white,
              title: 'Submit',
              icon: Icons.done,
              onTap: () {
                if(reviewCartProvider.getYourCartList.isEmpty) {
                  Get.snackbar(
                    '!',
                    'please select atleast 1 product',
                    snackPosition: SnackPosition.TOP,
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    colorText: Colors.white
                  );
                } else {
                  Get.to(() => DeliveryDetails());
                }
              },
            ),
          ],
        ),

        
        body: reviewCartProvider.yourCartList.isEmpty
            ? Center(
                child: Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.close_rounded,
                      size: 20,
                      color: Colors.red,
                    ),
                    SizedBox(width: 10,),
                    Text(
                      'NO DATA',
                      style: TextStylz.herbsName.copyWith(fontSize: 20),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                itemCount: reviewCartProvider.yourCartList.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ReviewCartData(
                        cartId: reviewCartProvider.yourCartList[index].cartId,
                        cartName:
                            reviewCartProvider.yourCartList[index].cartName,
                        cartImage:
                            reviewCartProvider.yourCartList[index].cartImage,
                        cartPrice:
                            reviewCartProvider.yourCartList[index].cartPrice,
                        cartCategory:
                            reviewCartProvider.yourCartList[index].cartCategory,
                        cartQuantity:
                            reviewCartProvider.yourCartList[index].cartQuantity,
                        cartUnit:
                            reviewCartProvider.yourCartList[index].cartUnit,
                        onDelete: () {
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: const Text("Cart Product"),
                              content: const Text(
                                  "Are you sure to delete this product?"),
                              actions: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(ctx).pop();
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.grey.shade300),
                                        child: const Text(
                                          "No",
                                          style: TextStyle(color: Colors.green),
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        reviewCartProvider
                                            .deleteReviewCartProduct(
                                                reviewCartProvider
                                                    .yourCartList[index]
                                                    .cartId);
                                        Navigator.of(ctx).pop();
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.grey.shade300),
                                        child: const Text(
                                          "Yes",
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      ),
                      CustomDivider(
                          horizontalPadding: 25,
                          height: 1,
                          color: Colors.teal,
                          thickness: 1),
                    ],
                  );
                },
              ));
  }
}

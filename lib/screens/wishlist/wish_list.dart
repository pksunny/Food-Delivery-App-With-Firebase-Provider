// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:food_delivery_with_provider_using_firebase_app/controller/common_dialog.dart';
import 'package:food_delivery_with_provider_using_firebase_app/screens/review/review_cart_data.dart';
import 'package:food_delivery_with_provider_using_firebase_app/screens/wishlist/wish_list_data.dart';
import 'package:food_delivery_with_provider_using_firebase_app/services/review_cart_provider.dart';
import 'package:food_delivery_with_provider_using_firebase_app/services/wish_list_provider.dart';
import 'package:food_delivery_with_provider_using_firebase_app/utils/screen_size.dart';
import 'package:food_delivery_with_provider_using_firebase_app/utils/text_stylz.dart';
import 'package:food_delivery_with_provider_using_firebase_app/widgets/custom_alert_dialog.dart';
import 'package:food_delivery_with_provider_using_firebase_app/widgets/custom_divider.dart';
import 'package:food_delivery_with_provider_using_firebase_app/widgets/custom_icon_button.dart';
import 'package:food_delivery_with_provider_using_firebase_app/widgets/custom_icon_text_button.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class WishList extends StatefulWidget {
  const WishList({super.key});

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {

  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WishListProvider wishListProvider = Provider.of(context, listen: false);
    wishListProvider.getWishListData();
  }

  @override
  Widget build(BuildContext context) {
    WishListProvider wishListProvider = Provider.of(context);

    return Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Text('Wish List'),
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: wishListProvider.yourWishList.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                WishListData(
                  cartId: wishListProvider.yourWishList[index].wishListId,
                  cartName: wishListProvider.yourWishList[index].wishListName,
                  cartImage: wishListProvider.yourWishList[index].wishListImage,
                  cartPrice: wishListProvider.yourWishList[index].wishListPrice,
                  cartCategory: wishListProvider.yourWishList[index].wishListCategory,
                  cartQuantity: wishListProvider.yourWishList[index].wishListQuantity,

                  onDelete: (){
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text("Wish List"),
                        content:
                            const Text("Are you sure to remove this item from wishlist?"),
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
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey.shade300
                                  ),
                                  child: const Text("No", style: TextStyle(color: Colors.green),),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  wishListProvider.deleteWishListData(
                                    wishListProvider.yourWishList[index].wishListId
                                  );
                                  Navigator.of(ctx).pop();
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey.shade300
                                  ),
                                  child: const Text("Yes", style: TextStyle(color: Colors.red),),
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

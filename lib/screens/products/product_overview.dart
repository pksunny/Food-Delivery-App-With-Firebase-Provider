// ignore_for_file: prefer_const_constructors

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_with_provider_using_firebase_app/models/wish_list_model.dart';
import 'package:food_delivery_with_provider_using_firebase_app/screens/review/review_cart.dart';
import 'package:food_delivery_with_provider_using_firebase_app/services/firebase_auth_method.dart';
import 'package:food_delivery_with_provider_using_firebase_app/services/wish_list_provider.dart';
import 'package:food_delivery_with_provider_using_firebase_app/utils/screen_size.dart';
import 'package:food_delivery_with_provider_using_firebase_app/utils/text_stylz.dart';
import 'package:food_delivery_with_provider_using_firebase_app/widgets/custom_bottom_navbar.dart';
import 'package:food_delivery_with_provider_using_firebase_app/widgets/custom_quantity_button.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ProductOverview extends StatefulWidget {
  ProductOverview({
    super.key,
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.productImage,
    required this.productCategory,
  });

  final String productId;
  final String productName;
  final int productPrice;
  final String productImage;
  final String productCategory;


  @override
  State<ProductOverview> createState() => _ProductOverviewState();
}

class _ProductOverviewState extends State<ProductOverview> {

  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // FOR MAINTAIN WISHLIST ADDED OR NOT
  bool wishList = false;

  // FOR MANAGE IF WISHLIST ADDED THA ICON SHOULD BE STAY FAVOURITE UNTIL IT UNCHECK WISHLIST
  getWishListBool(){
    FirebaseFirestore.instance
      .collection('wishlist')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('yourwishlist')
      .doc(widget.productId)
      .get()
      .then((value) {
        if(this.mounted){
          if(value.exists){
            setState(() {
              wishList = value.get('wishList');
            });
          }
        }
      });
  }

  @override
  Widget build(BuildContext context) {

    WishListProvider wishListProvider = Provider.of(context);
    FirebaseAuthMethods firebaseAuthMethods = Provider.of(context);

    // FOR MAINATIN WISHLIST ADDED OR NOT ALSO ICON CHECK OR NOT
    getWishListBool();

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Product Overview'),
        centerTitle: true,
      ),

      bottomNavigationBar: Row(
        children: [

          CustomBottomNavbar(
            iconColor: Colors.white, 
            backgroundColor: Colors.teal.shade400, 
            color: Colors.white, 
            title: 'Add to wishlist', 
            icon: wishList == false ? Icons.favorite_border : Icons.favorite_outlined,

            onTap: (){
              setState((){
                wishList = !wishList;
              });

              if(wishList == true) {

                wishListProvider.addWishListData(
                  widget.productId, 
                  widget.productName, 
                  widget.productImage, 
                  widget.productPrice, 
                  widget.productCategory, 
                  1, 
                  firebaseAuthMethods.userId
                );
              } else {
                wishListProvider.deleteWishListData(widget.productId);
              }
            },
          ),

          CustomBottomNavbar(
            iconColor: Colors.white, 
            backgroundColor: Colors.teal, 
            color: Colors.white, 
            title: 'Go to cart', 
            icon: Icons.card_travel_outlined,

            onTap: (){
              Get.to(() => ReviewCart());
            },
          ),
        ],
      ),

      body: Column(
        children: [

          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            width: ScreenSize(context).width,
            height: ScreenSize(context).height * 0.75,
            child: Card(
              elevation: 20,
              shadowColor: Colors.black,
              color: Colors.grey.shade200,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),

              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(widget.productName, style: TextStylz.herbsName,),
                    SizedBox(height: 3,),
                    Text('\$${widget.productPrice}', style: TextStylz.herbsGram,),

                    Container(
                      width: ScreenSize(context).width,
                      height: ScreenSize(context).height * 0.3,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(widget.productImage)
                        )
                      ),
                    ),

                    SizedBox(height: 5,),
                    Text('Available options', style: TextStylz.herbsName,),

                    SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Container(
                          width: ScreenSize(context).width * 0.05,
                          height: ScreenSize(context).height * 0.05,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(width: 2, color: Colors.teal),
                          ),
                        ),

                        Text('\$${widget.productPrice}', style: TextStylz.herbsGram,),
                        
                        // CUSTOM QUANTITY BUTTON
                        CustomQuantityButton(
                          productId: widget.productId, 
                          productName: widget.productName,
                          productImage: widget.productImage, 
                          productCategory: widget.productCategory, 
                          productPrice: widget.productPrice, 
                          productQuantity: 1,
                          productUnit: '500 Gram',
                        ),
                        // Container(
                        //   width: ScreenSize(context).width * 0.2,
                        //   height: ScreenSize(context).height * 0.05,
                        //   decoration: BoxDecoration(
                        //     // color: Colors.white,
                        //     borderRadius: BorderRadius.circular(15),
                        //     border: Border.all(width: 3, color: Colors.teal),
                        //   ),
                        //   child: Padding(
                        //     padding: const EdgeInsets.symmetric(horizontal: 5),
                        //     child: Row(
                        //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //       children: [

                        //         Icon(Icons.add, color: Colors.teal,),
                        //         Text('Add', style: TextStylz.drawerLoginName.copyWith(color: Colors.black54)),
                        //       ],
                        //     ),
                        //   ),
                        // ),

                      ],
                    ),

                    SizedBox(height: 15,),
                    Text('About this product', style: TextStylz.herbsName,),

                    SizedBox(height: 10,),
                    Text('Herb is a very useful diet to follow for maintain your health and it will provide you a lot of benefits in life.', style: TextStylz.herbsGram,),
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
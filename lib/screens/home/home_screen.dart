// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:food_delivery_with_provider_using_firebase_app/models/product_model.dart';
import 'package:food_delivery_with_provider_using_firebase_app/screens/home/drawer_screen.dart';
import 'package:food_delivery_with_provider_using_firebase_app/screens/home/fruits_data_homescreen.dart';
import 'package:food_delivery_with_provider_using_firebase_app/screens/home/herbs_data_homescreen.dart';
import 'package:food_delivery_with_provider_using_firebase_app/screens/products/product_overview.dart';
import 'package:food_delivery_with_provider_using_firebase_app/screens/review/review_cart.dart';
import 'package:food_delivery_with_provider_using_firebase_app/screens/search/search_screen.dart';
import 'package:food_delivery_with_provider_using_firebase_app/services/firebase_auth_method.dart';
import 'package:food_delivery_with_provider_using_firebase_app/services/product_provider.dart';
import 'package:food_delivery_with_provider_using_firebase_app/utils/screen_size.dart';
import 'package:food_delivery_with_provider_using_firebase_app/utils/text_stylz.dart';
import 'package:food_delivery_with_provider_using_firebase_app/widgets/custom_icon_button.dart';
import 'package:food_delivery_with_provider_using_firebase_app/widgets/double_text_widget.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late ProductProvider productProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ProductProvider productProvider = Provider.of(context, listen: false);
    productProvider.getHerbsProduct();
    productProvider.getFruitsProduct();
    productProvider.getAllProduct();
    // FirebaseAuthMethods firebaseAuthMethods = Provider.of(context);
    // firebaseAuthMethods.getUserProfileData();
  }

  @override
  Widget build(BuildContext context) {

    ProductModel productModel;

    FirebaseAuthMethods firebaseAuthMethods = Provider.of<FirebaseAuthMethods>(context);
    productProvider = Provider.of(context);
    // productProvider.allFruitsProduct;

    // firebaseAuthMethods.getUserProfileData();
    
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      drawer: DrawerScreen(),
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Home Screen', style: TextStyle(color: Colors.white),),
        centerTitle: true,

        actions: [

          CircleAvatar(
            backgroundColor: Colors.teal.shade300,
            child: CustomIconButton(
              onPressed: (){
                Get.to(SearchScreen(searchList: productProvider.getAllProductList,));
              },
              icon: Icons.search, 
              color: Colors.white,
            ),
          ),

          SizedBox(width: ScreenSize(context).width * 0.02,),
          CircleAvatar(
            backgroundColor: Colors.teal.shade300,
            child: CustomIconButton(
              onPressed: (){
                Get.to(() => ReviewCart());
              },
              icon: Icons.shopping_bag_outlined, 
              color: Colors.white,
            ),
          ),

          IconButton(
            onPressed: (){
              firebaseAuthMethods.deleteAccount();
            }, 
            icon: Icon(Icons.delete_forever_outlined, color: Colors.white,)
          ),
        ],
      ),

      body: ListView(
        children: [
          
          // FIRST CONTAINER IMAGE
          Container(
            width: ScreenSize(context).width,
            height: ScreenSize(context).height * 0.2,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.teal,
              image: DecorationImage(
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.grey.withOpacity(0.7), BlendMode.modulate),
                image: NetworkImage("https://img.freepik.com/premium-photo/healthy-food-clean-eating-selection_79782-19.jpg?w=2000")
              )
            ),
      
            child: Row(
              children: [
      
                Column(
                  children: [
                    Container(
                      width: ScreenSize(context).width * 0.30,
                      height: ScreenSize(context).height * 0.1,
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomRight: Radius.circular(50),
                          bottomLeft: Radius.circular(50),
                        ),
                        color: Colors.teal,
                        // ignore: prefer_const_literals_to_create_immutables
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 5,
                            color: Colors.black,
                            offset: Offset(0,5),
                          )
                        ]
                      ),
      
                      child: Text('FOODIES', style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),),
                    ),
                  ],
                ),
      
                Column(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    SizedBox(height: ScreenSize(context).height * 0.06,),
                    Text('30% OFF', style: TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold),),
                    Text('on all vegetables', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),),
                  
                  ],
                ),
                  
              ],
            ),
          ),
      
          // SECOND HERBS
          SizedBox(height: ScreenSize(context).height * 0.02,),
          AppDoubleTextWidget(
            bigText: "Herbs Seasoning", 
            smallText: "View all",
            onTap: (){
              Get.to(SearchScreen(searchList: productProvider.allHerbsProduct,));
            },
          ),
      
          // SECOND HERBS CONTAINER
          SizedBox(height: ScreenSize(context).height * 0.02,),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: productProvider.getHerbsProductList.map((e) {
                return HerbsDataHomeScreen(
                    herbsId: e.productId,
                    herbsName: e.productName,
                    herbsPrice: e.productPrice.toString(),
                    herbsImage: e.productImage,
                    productCategory: e.productCategory,
                    productModel: e,
                    onTap: (){
                      Get.to(ProductOverview(
                        productId: e.productId,
                        productName: e.productName,
                        productPrice: e.productPrice,
                        productImage: e.productImage,
                        productCategory: e.productCategory,
                      ));
                    }
                );
              }).toList(),
            ),
          ),
      
          // THIRD FRESH FRUITS
          SizedBox(height: ScreenSize(context).height * 0.02,),
          AppDoubleTextWidget(
            bigText: "Fresh Fruits", 
            smallText: "View all",
            onTap: (){
              Get.to(SearchScreen(searchList: productProvider.allFruitsProduct,));
            },
          ),
      
          // THIRD FRESH FRUITS CONTAINER
          SizedBox(height: ScreenSize(context).height * 0.02,),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: productProvider.getFruitProductList.map((e) {
                return FruitsDataHomeScreen(
                    fruitId: e.productId,
                    fruitName: e.productName,
                    fruitPrice: e.productPrice.toString(),
                    fruitImage: e.productImage,
                    productCategory: e.productCategory,
                    productModel: e,

                    onTap: (){
                      Get.to(ProductOverview(
                        productId: e.productId,
                        productName: e.productName,
                        productPrice: e.productPrice,
                        productImage: e.productImage,
                        productCategory: e.productCategory,
                      ));
                    },
                );
              }).toList(),
            ),
          )
          
        ],
      ),
    );
  }
}
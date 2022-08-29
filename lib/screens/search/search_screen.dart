// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:food_delivery_with_provider_using_firebase_app/models/product_model.dart';
import 'package:food_delivery_with_provider_using_firebase_app/screens/search/search_items.dart';
import 'package:food_delivery_with_provider_using_firebase_app/utils/screen_size.dart';
import 'package:food_delivery_with_provider_using_firebase_app/widgets/custom_divider.dart';
import 'package:food_delivery_with_provider_using_firebase_app/widgets/custom_text_field.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({super.key, required this.searchList});

  List<ProductModel> searchList = [];

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  String query = '';

  searchItem(String query) {

    List<ProductModel> searchProduct = widget.searchList.where((element) {

      return element.productName.toLowerCase().contains(query);
    }).toList();

    return searchProduct;
  }

  @override
  Widget build(BuildContext context) {

    List<ProductModel> _searchItem = searchItem(query);

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: Text('Search'),
        centerTitle: true,
        backgroundColor: Colors.teal,

        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.menu_rounded),
          )
        ],
      ),

      body: ListView(
        children: [

          ListTile(
            title: Text('Items'),
          ),

          Container(
            width: ScreenSize(context).width,
            height: ScreenSize(context).height * 0.07,
            margin: EdgeInsets.symmetric(horizontal: 20),
            // decoration: BoxDecoration(
            //   borderRadius: BorderRadius.circular(10),
            //   border: Border.all(width: 2, color: Colors.teal)
            // ),
            child: TextFormField(
              style: TextStyle(color: Colors.white),
              onChanged: (value){
                setState(() {
                  query = value;
                  print(value); 
                });
              },
              cursorColor: Colors.white,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                // border: OutlineInputBorder(
                //   // borderRadius: BorderRadius.circular(15),
                //   // borderSide:
                //   //     const BorderSide(color: Colors.transparent, width: 0),
                // ),
                // enabledBorder: OutlineInputBorder(
                //   borderRadius: BorderRadius.circular(10),
                //   borderSide: const BorderSide(color: Colors.transparent, width: 0),
                // ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                filled: true,
                fillColor: Colors.teal,
                hintText: 'Search Item',
                hintStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
                prefixIcon: Icon(Icons.search, color: Colors.white),
              ),
            ),
          ),

          SizedBox(height: 10,),

          Column(
            children: _searchItem.map((e) {

              return SearchItems(
                productId: e.productId,
                productName: e.productName,
                productPrice: e.productPrice,
                productImage: e.productImage,
                productCategory: e.productCategory,
              );

            }).toList(),
          )

        ],
      ),
    );
  }
}
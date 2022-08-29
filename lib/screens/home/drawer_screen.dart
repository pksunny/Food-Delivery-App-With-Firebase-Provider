// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:food_delivery_with_provider_using_firebase_app/screens/home/home_screen.dart';
import 'package:food_delivery_with_provider_using_firebase_app/screens/products/add_product_screen.dart';
import 'package:food_delivery_with_provider_using_firebase_app/screens/profile/my_profile.dart';
import 'package:food_delivery_with_provider_using_firebase_app/screens/review/review_cart.dart';
import 'package:food_delivery_with_provider_using_firebase_app/screens/wishlist/wish_list.dart';
import 'package:food_delivery_with_provider_using_firebase_app/services/firebase_auth_method.dart';
import 'package:food_delivery_with_provider_using_firebase_app/utils/screen_size.dart';
import 'package:food_delivery_with_provider_using_firebase_app/utils/text_stylz.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../widgets/custom_drawer_list_tile.dart';

class DrawerScreen extends StatefulWidget {
  DrawerScreen({super.key,});

  // FirebaseAuthMethods? firebaseAuthMethods;

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // FirebaseAuthMethods firebaseAuthMethods = Provider.of(context);
    // firebaseAuthMethods.getUserProfileData();

  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuthMethods firebaseAuthMethods = Provider.of(context);
    print(firebaseAuthMethods.yourProfileList.length);

    return Drawer(
      child: Container(
        color: Colors.teal.shade300,
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.teal),
              child: Row(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.tealAccent,
                    radius: 45,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.teal,
                      backgroundImage: AssetImage("assets/images/logo.png"),
                    ),
                  ),
                  SizedBox(
                    width: ScreenSize(context).width * 0.02,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome Guest',
                        style: TextStylz.GuestName,
                      ),

                      SizedBox(
                        height: ScreenSize(context).height * 0.02,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                            firebaseAuthMethods.getUserProfileList.map((e) {
                          return profileColumn(
                            e.user_name,
                            e.email,
                          );
                        }).toList(),
                      )

                      // Container(
                      //   height: ScreenSize(context).height * 0.05,
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(15),
                      //     border: Border.all(color: Colors.white, width: 2),
                      //   ),
                      //   child: OutlinedButton(
                      //     onPressed: (){},
                      //     child: Text('Login', style: TextStylz.drawerLoginName,),

                      //   ),

                      // )
                    ],
                  )
                ],
              ),
            ),
            CustomDrawerListTile(
              icon: Icons.home,
              title: 'Home',
              onTap: () {
                Get.to(HomeScreen());
              },
            ),
            CustomDrawerListTile(
              icon: Icons.add_shopping_cart_sharp,
              title: 'Add New Product',
              onTap: () {
                Get.to(AddProductScreen());
              },
            ),
            CustomDrawerListTile(
              icon: Icons.card_travel_outlined,
              title: 'Review Cart',
              onTap: () {
                Get.to(() => ReviewCart());
              },
            ),
            CustomDrawerListTile(
              icon: Icons.person,
              title: 'My Profile',
              onTap: () {
                Get.to(() => MyProfile());
              },
            ),
            CustomDrawerListTile(
              icon: Icons.notifications_active_outlined,
              title: 'Notifications',
              onTap: () {},
            ),
            CustomDrawerListTile(
              icon: Icons.star_border,
              title: 'Rating & Review',
              onTap: () {},
            ),
            CustomDrawerListTile(
              icon: Icons.favorite_border,
              title: 'Wishlist',
              onTap: () {
                Get.to(() => WishList());
              },
            ),
            CustomDrawerListTile(
              icon: Icons.note_alt_outlined,
              title: 'Raise a Complaint',
              onTap: () {},
            ),
            CustomDrawerListTile(
              icon: Icons.format_quote_rounded,
              title: 'FAQs',
              onTap: () {},
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Contact Support'),
                  SizedBox(
                    height: ScreenSize(context).height * 0.01,
                  ),
                  Row(
                    children: [
                      Text('Call us:'),
                      Text('+92312151515'),
                    ],
                  ),
                  SizedBox(
                    height: ScreenSize(context).height * 0.01,
                  ),
                  Row(
                    children: [
                      Text('Mail us:'),
                      Text('mail@gmail.com'),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget profileColumn(username, email) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(username, style: TextStylz.GuestName,), 
        Text(email, style: TextStylz.herbQuantity,)
      ],
    );
  }
}

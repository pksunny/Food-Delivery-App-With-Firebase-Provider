// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:food_delivery_with_provider_using_firebase_app/screens/home/drawer_screen.dart';
import 'package:food_delivery_with_provider_using_firebase_app/screens/signup%20signin/sign_in_screen.dart';
import 'package:food_delivery_with_provider_using_firebase_app/services/firebase_auth_method.dart';
import 'package:food_delivery_with_provider_using_firebase_app/utils/screen_size.dart';
import 'package:food_delivery_with_provider_using_firebase_app/utils/text_stylz.dart';
import 'package:food_delivery_with_provider_using_firebase_app/widgets/custom_profile_list_tile.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    FirebaseAuthMethods firebaseAuthMethods =
        Provider.of<FirebaseAuthMethods>(context);

    return Scaffold(
      backgroundColor: Colors.teal,
      drawer: DrawerScreen(),
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 0.0,
        title: Text('My Profile'),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: ScreenSize(context).height * 0.2,
                  color: Colors.teal,
                ),
                Expanded(
                  child: Card(
                    color: Colors.grey.shade300,
                    elevation: 30,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50))),
                    child: ListView.builder(
                      itemCount: firebaseAuthMethods.yourProfileList.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [

                            SizedBox(height: 20,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [

                                SizedBox(width: 50,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      firebaseAuthMethods.yourProfileList[index].user_name,
                                      style: TextStylz.herbsName,
                                    ),
                                    Text(
                                      firebaseAuthMethods.yourProfileList[index].email,
                                      style: TextStylz.herbsGram,
                                    ),
                                  ],
                                ),

                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.teal,
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Divider(
                              height: 1,
                              color: Colors.teal,
                            ),
                            CustomProfileListTile(
                                leadingIcon:
                                    Icons.production_quantity_limits_outlined,
                                title: 'My Orders',
                                onTap: () {}),
                            CustomProfileListTile(
                                leadingIcon: Icons.location_on_outlined,
                                title: 'My Delivery Address',
                                onTap: () {}),
                            CustomProfileListTile(
                                leadingIcon: Icons.person_add,
                                title: 'Refer a Fiends',
                                onTap: () {}),
                            CustomProfileListTile(
                                leadingIcon:
                                    Icons.production_quantity_limits_outlined,
                                title: 'My Orders',
                                onTap: () {}),
                            CustomProfileListTile(
                                leadingIcon: Icons.file_copy_outlined,
                                title: 'Terms & Conditions',
                                onTap: () {}),
                            CustomProfileListTile(
                                leadingIcon: Icons.policy_outlined,
                                title: 'Privacy Policy',
                                onTap: () {}),
                            CustomProfileListTile(
                                leadingIcon: Icons.info_outline,
                                title: 'About',
                                onTap: () {}),
                            CustomProfileListTile(
                                leadingIcon: Icons.logout_outlined,
                                title: 'Logout',
                                onTap: () {
                                  firebaseAuthMethods.signOut();
                                  Get.off(SignInScreen());
                                }),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: ScreenSize(context).height * 0.1,
              left: ScreenSize(context).width * 0.1,
              child: CircleAvatar(
                radius: 55,
                backgroundColor: Colors.teal,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage("assets/images/logo.png"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:food_delivery_with_provider_using_firebase_app/screens/delivery/google%20map/google_map.dart';
import 'package:food_delivery_with_provider_using_firebase_app/services/delivery_provider.dart';
import 'package:food_delivery_with_provider_using_firebase_app/utils/text_stylz.dart';
import 'package:food_delivery_with_provider_using_firebase_app/widgets/custom_bottom_navbar.dart';
import 'package:food_delivery_with_provider_using_firebase_app/widgets/custom_text_field.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

// FOR MANAGE RADIO BUTTON
enum AddressType{
  Home,
  Work,
  Other
}

class AddDeliverAddress extends StatefulWidget {
  const AddDeliverAddress({super.key});

  @override
  State<AddDeliverAddress> createState() => _AddDeliverAddressState();
}

class _AddDeliverAddressState extends State<AddDeliverAddress> {

  // MANAGE RADIO BUTTON
  AddressType? myAddressType = AddressType.Home;

  @override
  Widget build(BuildContext context) {

    DeliveryProvider deliveryProvider = Provider.of(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: Text('Add Address'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),

      // CUSTOM BOTTOM NAV BAR
        bottomNavigationBar: Row(
        children: [

          CustomBottomNavbar(
            iconColor: Colors.white, 
            backgroundColor: Colors.teal, 
            color: Colors.white, 
            title: 'Add new address',
            icon: Icons.home_outlined,

            onTap: (){
              deliveryProvider.validator(myAddressType);
            },
          ),
        ],
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: ListView(
          children: [
      
            CustomTextField(
              controller: deliveryProvider.firstNameController, 
              hintText: 'First Name',
            ),

            SizedBox(height: 20,),
            CustomTextField(
              controller: deliveryProvider.lastNameController, 
              hintText: 'Last Name',
            ),

            SizedBox(height: 20,),
            CustomTextField(
              controller: deliveryProvider.mobileNoController, 
              hintText: 'Mobile No',
            ),

            SizedBox(height: 20,),
            CustomTextField(
              controller: deliveryProvider.alternateMobileNoController, 
              hintText: 'Alternate Mobile No',
            ),
      
            SizedBox(height: 20,),
            CustomTextField(
              controller: deliveryProvider.societyController, 
              hintText: 'Society',
            ),

            SizedBox(height: 20,),
            CustomTextField(
              controller: deliveryProvider.streetController, 
              hintText: 'Street',
            ),

            SizedBox(height: 20,),
            CustomTextField(
              controller: deliveryProvider.landMarkController, 
              hintText: 'Landmark',
            ),
            
            SizedBox(height: 20,),
            CustomTextField(
              controller: deliveryProvider.cityController, 
              hintText: 'City',
            ),
            
            SizedBox(height: 20,),
            CustomTextField(
              controller: deliveryProvider.areaController, 
              hintText: 'Area',
            ),

            SizedBox(height: 20,),
            CustomTextField(
              controller: deliveryProvider.pinCodeController, 
              hintText: 'Pincode',
            ),

            SizedBox(height: 20,),
            InkWell(
              onTap: (){
                Get.to(() => CustomGoogleMap());
              },
              child: Container(
                width: double.infinity,
                height: 50,
                margin: EdgeInsets.symmetric(horizontal: 30),
                padding: EdgeInsets.symmetric(horizontal: 50),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.teal,
                  border: Border.all(width: 1, color: Colors.black),
                  // ignore: prefer_const_literals_to_create_immutables
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 3,
                      color: Colors.black,
                      offset: Offset(1,2)
                    )
                  ]
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    deliveryProvider.setLocation?.latitude == null ? Text('Set Location', style: TextStyle(color: Colors.white),) :
                    Text('Your Location has been set', style: TextStyle(color: Colors.white),)
                    // Text('Set Location', style: TextStyle(color: Colors.white),)
                  ],
                ),
              ),
            ),

            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListTile(
                title: Text('Address Type*', style: TextStylz.GuestName.copyWith(color: Colors.black54),),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [

                  RadioListTile<AddressType>(
                      title: Text('Home'),
                      secondary: Icon(
                        Icons.home_outlined,
                        color: Colors.teal,
                      ),
                      activeColor: Colors.teal,
                      value: AddressType.Home,
                      groupValue: myAddressType,
                      onChanged: (AddressType? value) async {
                        setState(() {
                          myAddressType = value!;
                        });
                      },
                    ),

                    RadioListTile<AddressType>(
                      title: Text('Work'),
                      secondary: Icon(
                        Icons.maps_home_work_sharp,
                        color: Colors.teal,
                      ),
                      activeColor: Colors.teal,
                      value: AddressType.Work,
                      groupValue: myAddressType,
                      onChanged: (AddressType? value) async {
                        setState(() {
                          myAddressType = value!;
                        });
                      },
                    ),

                    RadioListTile<AddressType>(
                      title: Text('Other'),
                      secondary: Icon(
                        Icons.house_outlined,
                        color: Colors.teal,
                      ),
                      activeColor: Colors.teal,
                      value: AddressType.Other,
                      groupValue: myAddressType,
                      onChanged: (AddressType? value) async {
                        setState(() {
                          myAddressType = value!;
                        });
                      },
                    ),
                ],
              )
            ),

            SizedBox(height: 20,),
      
          ],
        ),
      ),
    );
  }
}
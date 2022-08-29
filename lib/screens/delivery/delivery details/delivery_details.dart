// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison, prefer_if_null_operators

import 'package:flutter/material.dart';
import 'package:food_delivery_with_provider_using_firebase_app/models/delivery_model.dart';
import 'package:food_delivery_with_provider_using_firebase_app/screens/delivery/add%20delivery%20address/add_delivery_address.dart';
import 'package:food_delivery_with_provider_using_firebase_app/screens/delivery/delivery%20details/delivery_data.dart';
import 'package:food_delivery_with_provider_using_firebase_app/screens/delivery/payment%20summary/payment_summary.dart';
import 'package:food_delivery_with_provider_using_firebase_app/services/delivery_provider.dart';
import 'package:food_delivery_with_provider_using_firebase_app/utils/text_stylz.dart';
import 'package:food_delivery_with_provider_using_firebase_app/widgets/custom_bottom_navbar.dart';
import 'package:food_delivery_with_provider_using_firebase_app/widgets/custom_divider.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class DeliveryDetails extends StatefulWidget {
  const DeliveryDetails({super.key});

  @override
  State<DeliveryDetails> createState() => _DeliveryDetailsState();
}

class _DeliveryDetailsState extends State<DeliveryDetails> {
  // MANAGE IF ADDRESS ADDED OR NOT

  // List<Widget> address = [
  //   DeliveryData(
  //     title: 'Sunny',
  //     address: 'dhoke mughal abad tehsil kahuta district rawalpindi',
  //     number: '03121529111',
  //     addressType: 'Home',
  //   )
  // ];


  late DeliveryModel deliveryModel;

  @override
  Widget build(BuildContext context) {
    DeliveryProvider deliveryProvider = Provider.of(context);
    deliveryProvider.getDeliveryAddressData();

    return Scaffold(
      backgroundColor: Colors.grey.shade300,

      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Delivery Details'),
        centerTitle: true,
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        child: Icon(Icons.add),
        onPressed: () {
          Get.to(() => AddDeliverAddress());
        },
      ),

      // CUSTOM BOTTOM NAV BAR
      bottomNavigationBar: Row(
        children: [
          CustomBottomNavbar(
            iconColor: Colors.white,
            backgroundColor: Colors.teal,
            color: Colors.white,
            title: deliveryProvider.getDeliverAddressList.isEmpty
                ? 'Add new address'
                : 'Payment Summary',
            icon: Icons.home_outlined,
            onTap: () {
              deliveryProvider.getDeliverAddressList.isEmpty
                  ? Get.to(() => AddDeliverAddress())
                  : Get.to(() => PaymentSummary(deliveryModel: deliveryModel,));
            },
          ),
        ],
      ),

      body: ListView(
        children: [
          ListTile(
            title: Text(
              'Deliver to',
              style: TextStylz.herbsName,
            ),
            leading: Icon(
              Icons.location_on_outlined,
              size: 25,
            ),
          ),
          CustomDivider(
              horizontalPadding: 20,
              height: 1,
              color: Colors.teal,
              thickness: 1),
              
          deliveryProvider.getDeliverAddressList.isEmpty
              ? Container(
                  child: Center(
                    child: Text(
                      'No Data',
                      style: TextStylz.herbsName.copyWith(fontSize: 20),
                    ),
                  ),
                )
              : Column(
                  children: deliveryProvider.getDeliverAddressList.map((e) {

                    // FOR SEND ADDRESS TO PAYMENT SUMMARy PAGE
                    setState(() {
                      deliveryModel = e;
                    });

                    return DeliveryData(
                      title: '${e.firstName} ${e.lastName}',
                      address: 'Area ${e.area}, street ${e.street}, society ${e.society}, pincode ${e.pinCode}',
                      number: '${e.mobileNo}',
                      addressType: e.addressType == "AddressType.Home" ? "Home" : 
                        e.addressType == "AddressType.Work" ? "Work" : "Other",
                    );
                  }).toList(),
                ),
        ],
      ),
    );
  }
}

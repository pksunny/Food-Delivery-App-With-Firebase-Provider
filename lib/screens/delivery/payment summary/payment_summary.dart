// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:food_delivery_with_provider_using_firebase_app/models/delivery_model.dart';
import 'package:food_delivery_with_provider_using_firebase_app/screens/delivery/delivery%20details/delivery_data.dart';
import 'package:food_delivery_with_provider_using_firebase_app/screens/delivery/delivery%20details/delivery_details.dart';
import 'package:food_delivery_with_provider_using_firebase_app/screens/delivery/payment%20summary/order_data.dart';
import 'package:food_delivery_with_provider_using_firebase_app/services/delivery_provider.dart';
import 'package:food_delivery_with_provider_using_firebase_app/services/product_provider.dart';
import 'package:food_delivery_with_provider_using_firebase_app/services/review_cart_provider.dart';
import 'package:food_delivery_with_provider_using_firebase_app/utils/text_stylz.dart';
import 'package:food_delivery_with_provider_using_firebase_app/widgets/custom_bottom_navbar.dart';
import 'package:food_delivery_with_provider_using_firebase_app/widgets/custom_divider.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

// FOR MANAGE RADIO BUTTON
enum PaymentType{
  Home,
  Online,
}

class PaymentSummary extends StatefulWidget {
  PaymentSummary({super.key, required this.deliveryModel});

  final DeliveryModel deliveryModel;

  @override
  State<PaymentSummary> createState() => _PaymentSummaryState();
}

class _PaymentSummaryState extends State<PaymentSummary> {

  // MANAGE RADIO BUTTON
  var myPaymentType = PaymentType.Home;


  @override
  Widget build(BuildContext context) {

    ReviewCartProvider reviewCartProvider = Provider.of(context);
    // reviewCartProvider.getYourCartProduct();

    // FOR MANAGE DISCOUNT
    double discount = 10;
    double shippingCharge = 5;
    double discountPrice;
    double totalDiscount = 0.0;
    double totalPrice = reviewCartProvider.getTotalPrice();
    if(totalPrice > 300){
      discountPrice = (totalPrice * discount) / 100 ;
      totalDiscount = totalPrice - discountPrice;
    }


    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: Text('Payment Summary'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),

      // CUSTOM BOTTOM NAV BAR
        bottomNavigationBar: Row(
          children: [
            CustomBottomNavbar(
              iconColor: Colors.white,
              backgroundColor: Colors.teal.shade400,
              color: Colors.white,
              title: 'Total: ${totalDiscount + shippingCharge ?? totalPrice}',
              icon: Icons.attach_money_rounded,
              onTap: () {},
            ),
            CustomBottomNavbar(
              iconColor: Colors.white,
              backgroundColor: Colors.teal,
              color: Colors.white,
              title: 'Place Order',
              icon: Icons.next_week_outlined,
              onTap: () {
                 Get.snackbar(
                    '!',
                    'please select atleast 1 product',
                    snackPosition: SnackPosition.TOP,
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    colorText: Colors.white
                  );
              },
            ),
          ],
        ),
        
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: ListView.builder(
            itemCount: 1,
            itemBuilder: ((context, index) {
              return Column(
                children: [

                  DeliveryData(
                      title: '${widget.deliveryModel.firstName} ${widget.deliveryModel.lastName}',
                      address: 'Area ${widget.deliveryModel.area}, street ${widget.deliveryModel.street}, society ${widget.deliveryModel.society}, pincode ${widget.deliveryModel.pinCode}',
                      number: '${widget.deliveryModel.mobileNo}',
                      addressType: widget.deliveryModel.addressType == "AddressType.Home" ? "Home" : 
                        widget.deliveryModel.addressType == "AddressType.Work" ? "Work" : "Other",
                    ),

                  // CustomDivider(horizontalPadding: 10, height: 1, color: Colors.teal, thickness: 1),

                  ExpansionTile(
                    title: Text('Order Item ${reviewCartProvider.getYourCartList.length}', style: TextStylz.herbsName,),
                    children: reviewCartProvider.getYourCartList.map((e) {
                      return OrderData(reviewCartModel: e,); 
                    }).toList(),
                  ),

                  CustomDivider(horizontalPadding: 10, height: 1, color: Colors.teal, thickness: 1),

                  ListTile(
                    minVerticalPadding: 5,
                    leading: Text("Sub Total", style: TextStylz.herbsName,),
                    trailing: Text("${reviewCartProvider.getTotalPrice() + 5}\$", style: TextStylz.herbsName,),
                  ),

                  ListTile(
                    leading: Text("Shipping Charge", style: TextStylz.herbsGram,),
                    trailing: Text("\$${shippingCharge}", style: TextStylz.herbsGram,),
                  ),                  

                  ListTile(
                    leading: Text("Discount", style: TextStylz.herbsGram,),
                    trailing: Text("${discount}\$", style: TextStylz.herbsGram,),
                  ),

                  CustomDivider(horizontalPadding: 10, height: 1, color: Colors.teal, thickness: 1),

                  ListTile(
                    leading: Text("Payment Options", style: TextStylz.herbsName,),
                  ),

                  Column(
                children: [

                  RadioListTile(
                      title: Text('Home'),
                      secondary: Icon(
                        Icons.home_outlined,
                        color: Colors.teal,
                      ),
                      activeColor: Colors.teal,
                      value: PaymentType.Home,
                      groupValue: myPaymentType,
                      onChanged: (PaymentType? value) async {
                        setState(() {
                          myPaymentType = value!;
                        });
                      },
                    ),

                    RadioListTile(
                      title: Text('Online'),
                      secondary: Icon(
                        Icons.broadcast_on_personal_outlined,
                        color: Colors.teal,
                      ),
                      activeColor: Colors.teal,
                      value: PaymentType.Online,
                      groupValue: myPaymentType,
                      onChanged: (PaymentType? value) async {
                        setState(() {
                          myPaymentType = value!;
                        });
                      },
                    ),

                ],
              )


                ],
              );
            }),
          ),
        ),
    );
  }
}
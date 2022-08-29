// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:food_delivery_with_provider_using_firebase_app/utils/text_stylz.dart';
import 'package:food_delivery_with_provider_using_firebase_app/widgets/custom_divider.dart';

class DeliveryData extends StatefulWidget {
  DeliveryData({
    super.key,
    required this.title,
    required this.address,
    required this.number,
    required this.addressType,
  });

  final String title, address, number, addressType;

  @override
  State<DeliveryData> createState() => _DeliveryDataState();
}

class _DeliveryDataState extends State<DeliveryData> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
        
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Text(widget.title, style: TextStylz.GuestName.copyWith(color: Colors.black54)),
              ),
        
        
              Container(
                width: 80,
                height: 25,
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(widget.addressType, style: TextStylz.GuestName,),
                ),
              ),
            ],
          ),

          // leading: CircleAvatar(
          //   radius: 8,
          //   backgroundColor: Colors.teal,
          // ),
          subtitle: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(widget.address, style: TextStylz.GuestName.copyWith(color: Colors.black54)),

                SizedBox(height: 5,),

                Text(widget.number, style: TextStylz.GuestName.copyWith(color: Colors.black54)),

              ],
            ),
          ),
        ),

        CustomDivider(
          horizontalPadding: 20, 
          height: 1, 
          color: Colors.teal, 
          thickness: 1
        ),
      ],
    );
  }
}
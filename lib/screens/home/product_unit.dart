// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:food_delivery_with_provider_using_firebase_app/utils/screen_size.dart';
import 'package:food_delivery_with_provider_using_firebase_app/utils/text_stylz.dart';

class ProductUnit extends StatefulWidget {
  ProductUnit({super.key, required this.title, required this.onTap});

  final String title;
  final VoidCallback onTap;

  @override
  State<ProductUnit> createState() => _ProductUnitState();
}

class _ProductUnitState extends State<ProductUnit> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        width: ScreenSize(context).width * 0.30,
        height: ScreenSize(context).height * 0.06,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            // color: Colors.teal
            border: Border.all(color: Colors.teal)),
        child: Row(
          children: [
            Text(
              widget.title,
              style: TextStylz.GramChange,
            ),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Colors.teal,
            )
          ],
        ),
      ),
    );
  }
}

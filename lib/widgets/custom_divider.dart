// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  CustomDivider({
    super.key,
    required this.horizontalPadding,
    required this.height,
    required this.color,
    required this.thickness,
  });

  double horizontalPadding;
  double height;
  Color color;
  double thickness;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Divider(
        height: height,
        color: color,
        thickness: thickness,
      ),
    );
  }
}

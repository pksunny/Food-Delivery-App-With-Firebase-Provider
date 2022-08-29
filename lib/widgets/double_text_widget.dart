// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class AppDoubleTextWidget extends StatelessWidget {
  final String bigText;
  final String smallText;
  final VoidCallback onTap;

  const AppDoubleTextWidget(
      {super.key, required this.bigText, required this.smallText, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            bigText,
            style: TextStyle(fontSize: 20)
          ),
          InkWell(
              onTap: onTap,
              child: Text(
                smallText,
                style: TextStyle(fontSize: 16, color: Colors.teal)
              ))
        ],
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:food_delivery_with_provider_using_firebase_app/utils/screen_size.dart';
import 'package:food_delivery_with_provider_using_firebase_app/utils/text_stylz.dart';

class CustomIconTextButton extends StatefulWidget {
  CustomIconTextButton({
    super.key,
    required this.onTap,
    required this.text,
    required this.icon
  });

  final VoidCallback onTap;
  final String text;
  IconData icon;

  @override
  State<CustomIconTextButton> createState() => _CustomIconTextButtonState();
}

class _CustomIconTextButtonState extends State<CustomIconTextButton> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(right: 20, left: 20),
        height: ScreenSize(context).height * 0.05,
        decoration: BoxDecoration(
            border: Border.all(width: 2, color: Colors.teal),
            borderRadius: BorderRadius.circular(15)),
        child: InkWell(
          onTap: widget.onTap,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  widget.icon,
                  color: Colors.teal,
                ),
                Text(
                  widget.text,
                  style:
                      TextStylz.drawerLoginName.copyWith(color: Colors.black54),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

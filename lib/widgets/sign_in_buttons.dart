// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class SignInButtons extends StatefulWidget {
  SignInButtons(
      {super.key, required this.icon, required this.iconSize, required this.text, required this.onTap});

  IconData icon;
  double iconSize;
  String text;
  void Function() onTap;

  @override
  State<SignInButtons> createState() => _SignInButtonsState();
}

class _SignInButtonsState extends State<SignInButtons> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 40),
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.teal,
            // ignore: prefer_const_literals_to_create_immutables
            boxShadow: [
              BoxShadow(
                  blurRadius: 3, offset: Offset(1, 3), color: Colors.black)
            ]),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Center(
            child: Row(
              // ignore: prefer_const_literals_to_create_immutables
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  widget.icon,
                  color: Colors.white,
                  size: widget.iconSize,
                ),
                
                Text(
                  widget.text,
                  style: TextStyle(fontSize: 16, color: Colors.white),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

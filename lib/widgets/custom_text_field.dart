// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData? suffixIcon;
  final bool obsecureText;
  final String? Function(String?)? validator;

  CustomTextField(
    {
      Key? key,
      required this.controller,
      required this.hintText,
      this.suffixIcon,
      this.obsecureText = false,
      this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        // ignore: prefer_const_literals_to_create_immutables
        boxShadow: [
          BoxShadow(
            blurRadius: 3,
            color: Colors.black,
            offset: Offset(1,3),
          )
        ]
      ),
      child: TextFormField(

        style: TextStyle(color: Colors.white),

        controller: controller,
        cursorColor: Colors.white,
        keyboardType: TextInputType.text,
        obscureText: obsecureText,
        validator: validator,

        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.transparent, width: 0),
          ),
          // enabledBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(10),
          //   borderSide: const BorderSide(color: Colors.transparent, width: 0),
          // ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          filled: true,
          fillColor: Colors.teal,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
          prefixIcon: Icon(suffixIcon, color: Colors.white),
        ),
      ),
    );
  }
}
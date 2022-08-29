// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CustomBottomNavbar extends StatefulWidget {
  CustomBottomNavbar({
    super.key,
    required this.iconColor,
    required this.backgroundColor,
    required this.color,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  Color iconColor;
  Color backgroundColor;
  Color color;
  String title;
  IconData icon;
  final VoidCallback onTap;

  @override
  State<CustomBottomNavbar> createState() => _CustomBottomNavbarState();
}

class _CustomBottomNavbarState extends State<CustomBottomNavbar> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: widget.onTap,
        child: Container(
          padding: EdgeInsets.all(20),
          color: widget.backgroundColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                widget.icon,
                size: 17,
                color: widget.iconColor,
              ),
      
              SizedBox(width: 5,),
      
              Text(widget.title, style: TextStyle(color: widget.color),),
            ],
          ),
        ),
      ),
    );
  }
}
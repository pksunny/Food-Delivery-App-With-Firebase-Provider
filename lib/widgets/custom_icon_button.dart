import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  CustomIconButton({
    super.key, 
    required this.onPressed,
    required this.icon,
    this.iconSize,
    this.color,
    });

  final IconData icon;
  final VoidCallback onPressed;
  final double? iconSize;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon),
      onPressed: onPressed,
      iconSize: iconSize,
      color: color,
    );
  }
}
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:food_delivery_with_provider_using_firebase_app/utils/text_stylz.dart';

class CustomProfileListTile extends StatefulWidget {
  CustomProfileListTile(
      {super.key,
      required this.leadingIcon,
      required this.title,
      required this.onTap});

  IconData leadingIcon;
  String title;
  void Function() onTap;

  @override
  State<CustomProfileListTile> createState() => _CustomProfileListTileState();
}

class _CustomProfileListTileState extends State<CustomProfileListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        widget.leadingIcon,
        size: 25,
      ),
      trailing: Icon(Icons.arrow_forward_ios_rounded),
      title: Text(
        widget.title,
        style: TextStylz.listTileText,
      ),
      onTap: widget.onTap,
    );
  }
}

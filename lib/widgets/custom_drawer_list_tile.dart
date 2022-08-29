import 'package:flutter/material.dart';
import 'package:food_delivery_with_provider_using_firebase_app/utils/text_stylz.dart';

class CustomDrawerListTile extends StatefulWidget {
  CustomDrawerListTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap
  });

  IconData icon;
  String title;
  void Function() onTap;

  @override
  State<CustomDrawerListTile> createState() => _CustomDrawerListTileState();
}

class _CustomDrawerListTileState extends State<CustomDrawerListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(

      leading: Icon(widget.icon, size: 25,),
      title: Text(widget.title, style: TextStylz.listTileText,),
      onTap: widget.onTap,
    );
  }
}
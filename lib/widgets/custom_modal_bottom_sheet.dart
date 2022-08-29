import 'package:flutter/material.dart';

class CustomModalBttomSheet extends StatefulWidget {
  const CustomModalBttomSheet({super.key});

  @override
  State<CustomModalBttomSheet> createState() => _CustomModalBttomSheetState();
}

class _CustomModalBttomSheetState extends State<CustomModalBttomSheet> {
  @override
  Widget build(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: new Text('50 Gram'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: new Text('500 Gram'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: new Text('1 Kg'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });

    return Container();
  }
}

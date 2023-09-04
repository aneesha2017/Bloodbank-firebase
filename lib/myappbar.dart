import 'package:flutter/material.dart';

class MyAppbar extends StatelessWidget implements PreferredSizeWidget {
  MyAppbar({
    Key? key,
    required this.title,
  }) : super(key: key);
  String title;
  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight); // Set your preferred height

  @override
  Widget build(BuildContext context) {
    return AppBar(backgroundColor: Colors.red, title: Text(title));
  }
}

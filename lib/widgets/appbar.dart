import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(245, 250, 251, 255),
        // backgroundColor: Color.fromRGBO(237, 245, 237, 1),
        
      );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
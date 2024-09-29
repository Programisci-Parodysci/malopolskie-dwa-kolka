import 'package:flutter/material.dart';


class HeaderText extends StatelessWidget{

  const HeaderText({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: const BoxDecoration(
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.0
        ),
        ),
    );
  }
}
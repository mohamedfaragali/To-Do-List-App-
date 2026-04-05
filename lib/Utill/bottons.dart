import 'package:flutter/material.dart';

class Bottons extends StatelessWidget {
  final String text;
  VoidCallback onPressed;
  Bottons({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Colors.yellow[500],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Text(text),
    );
  }
}

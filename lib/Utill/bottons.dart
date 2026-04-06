import 'package:flutter/material.dart';

class Bottons extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const Bottons({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: const Color.fromARGB(255, 8, 75, 192),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Text(text),
    );
  }
}

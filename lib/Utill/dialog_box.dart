import 'package:flutter/material.dart';
import 'package:todo_app/Utill/bottons.dart';

class DialogBox extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback? onSave;
  final VoidCallback? onCancel;

  const DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: SizedBox(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add a new task",
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Bottons(text: "Save", onPressed: onSave!),
                const SizedBox(width: 8),
                Bottons(text: "Cancel", onPressed: onCancel!),
              ],
            ),

            //buttons -> save + cancel
          ],
        ),
      ),
    );
  }
}

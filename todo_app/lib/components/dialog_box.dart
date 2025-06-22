import 'package:flutter/material.dart';

import 'my_button.dart';

class DialogBox extends StatelessWidget {
  const DialogBox({super.key, required this.controller, this.onSave, this.onCancel});

  final TextEditingController controller;
  final void Function()? onSave;
  final void Function()? onCancel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).primaryColor,
      content: Container(
        height: 150,
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Add New Task',
              ),
              controller: controller,
            ),
            Row(
              children: [
                MyButton(
                  buttonText: 'Save',
                  onPressed: onSave,
                ),
                SizedBox(width: 20),
                MyButton(
                  buttonText: 'Cancel',
                  onPressed: onCancel,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

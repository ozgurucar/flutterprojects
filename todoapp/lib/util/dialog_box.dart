// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:todoapp/util/my_button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  final VoidCallback saveNewTask;
  DialogBox({super.key, required this.controller, required this.saveNewTask});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow.shade300,
      content: Container(
        height: 120,
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "Add New To Do"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyButton(
                  text: "Cancel",
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(width: 6),
                MyButton(
                  text: "Save",
                  onPressed: saveNewTask,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

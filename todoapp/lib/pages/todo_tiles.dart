// ignore_for_file: prefer_const_constructors, override_on_non_overriding_member, annotate_overrides, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTile extends StatelessWidget {
  ToDoTile(
      {super.key,
      required this.taskName,
      required this.onChanged,
      required this.taskCompleted,
      required this.deleteFunction});

  @override
  final String taskName;

  final bool taskCompleted;

  Function(bool?)? onChanged;

  Function(BuildContext)? deleteFunction;

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25, top: 25),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.red.shade300,
              borderRadius: BorderRadius.circular(12),
            )
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.yellow, borderRadius: BorderRadius.circular(12)),
          padding: EdgeInsets.all(25),
          child: Row(
            children: [
              Checkbox(
                activeColor: Colors.black,
                value: taskCompleted,
                onChanged: onChanged,
              ),
              Text(
                taskName,
                style: TextStyle(
                    decoration: taskCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none),
              )
            ],
          ),
        ),
      ),
    );
  }
}

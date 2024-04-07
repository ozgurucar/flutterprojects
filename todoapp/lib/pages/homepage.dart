// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todoapp/pages/data/database.dart';
import 'package:todoapp/pages/todo_tiles.dart';
import 'package:todoapp/util/dialog_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

final _controller = TextEditingController();

final _myBox = Hive.box('myBox');
ToDoDataBase db = ToDoDataBase();

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow.shade200,
        appBar: AppBar(
          elevation: 0,
          title: Center(
            child: Text("TO DO"),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            createNewTask();
          },
        ),
        body: ListView.builder(
          itemCount: db.toDoList.length,
          itemBuilder: (context, index) {
            return ToDoTile(
              taskName: db.toDoList[index][0],
              onChanged: (value) => checkboxChanged(index),
              taskCompleted: db.toDoList[index][1],
              deleteFunction: (context) => deleteTask(index),
            );
          },
        ));
  }

  void checkboxChanged(int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          saveNewTask: saveNewTask,
        );
      },
    );
    db.updateDataBase();
  }

  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
    });
    Navigator.pop(context);
    _controller.clear();
    db.updateDataBase();
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }
}

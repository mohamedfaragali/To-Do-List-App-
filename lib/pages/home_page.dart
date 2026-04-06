import 'package:flutter/material.dart';
import 'package:todo_app/Utill/todo_tile.dart';
import 'package:todo_app/Utill/dialog_box.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/data/data_base.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // refrence the hive box
  late Box _myBox;
  ToDoDataBase db = ToDoDataBase();
  @override
  void initState() {
    super.initState();
    _initializeBox();
  }

  Future<void> _initializeBox() async {
    _myBox = await Hive.openBox("mybox");
    // for first time using app
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      // for already existing data
      db.loadData();
    }
    setState(() {});
  }

  // text controller
  final _controller = TextEditingController();

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  // save new task
  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
    _controller.clear();
  }

  // Create new task
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
    db.updateDataBase();
  }

  //delete task
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
  }

  // delete all tasks
  void deleteAllTasks() {
    setState(() {
      db.ClearTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: Text(
          "To Do",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Colors.yellow,
        centerTitle: true,
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: deleteAllTasks,
            child: const Icon(Icons.delete_sweep),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            onPressed: createNewTask,
            child: const Icon(Icons.add),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}

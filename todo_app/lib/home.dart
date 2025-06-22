import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/components/theme_button.dart';
import 'package:todo_app/components/todo_tile.dart';
import 'package:todo_app/todo_db/database.dart';
import 'components/dialog_box.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.changeTheme});

  final Function(bool useLightMode) changeTheme;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  //referenciar el box
  final _myBox = Hive.box('myBox');

  final _controller = TextEditingController();

  // List taskList = [
  //   ["Dar Clases", false],
  //   ["Comprar Cena", false],
  // ];

  //instanciar database
  DataBase db = DataBase();

  // Metodo para cambiar el estado del checkbox
  void checkBoxChange(bool? value, int index) {
    setState(() {
      //taskList[index][1] = !taskList[index][1];
      db.todoList[index][1] = !db.todoList[index][1];
      db.updateData();
    });
  }

  // Metodo para guardar una nueva task
  void saveNewTask() {
    setState(() {
      //taskList.add([_controller.text, false]);
      db.todoList.add([_controller.text, false]);
      db.updateData();
      Navigator.of(context).pop();
      _controller.clear();
    });
  }

  // Metodo para crear nueva task
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () {
            Navigator.pop(context);
            _controller.clear();
          },
        );
      },
    );
  }

  //preguntar si anteriormente se habian creado tasks
  @override
  void initState() {
    // TODO: implement initState
    if (_myBox.get("TODOLIST") == null){
      db.createInitialData();
    } else{
      //habia datos anteriormente, la cargamos
      db.loadData();
    }
    super.initState();
  }

  // Metodo para eliminar una task
  void deleteTask(int index) {
    setState(() {
      db.todoList.removeAt(index); //arreglar esto con la db
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To Do App'),
        actions: [
          ThemeButton(changeThemeMode: widget.changeTheme)
        ],
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor.withAlpha(120),
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: db.todoList.length,
        itemBuilder: (context, index) {
          return Slidable(
            key: ValueKey(index),
            endActionPane: ActionPane(
              motion: const BehindMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) => deleteTask(index),
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Eliminar',
                ),
              ],
            ),
            child: TodoTile(
              taskName: db.todoList[index][0],
              taskComplete: db.todoList[index][1],
              onChanged: (value) {
                checkBoxChange(value, index);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
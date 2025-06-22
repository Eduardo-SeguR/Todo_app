import 'package:hive/hive.dart';

class DataBase{
  List todoList = [];

  //referenciar el box
  final _myBox = Hive.box('myBox');

  //cargar datos desde la lista
  void loadData(){
    todoList = _myBox.get("TODOLIST");
  }

  //actualizar la lista
  void updateData(){
    _myBox.put("TODOLIST", todoList);
  }

  //crear datos inciales la primera vez qu se abre la app
  void createInitialData(){
    todoList = [

      // ["Comprar un BMW", false],
      // ["Comprar un penthouse", false]
    ];
  }
}
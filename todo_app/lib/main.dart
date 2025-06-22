import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_app/color_theme.dart';
import 'package:todo_app/home.dart';

void main() async {
  //inicializar hive
  await Hive.initFlutter();
  runApp(MyApp());

  //abrir caja
  var box = await Hive.openBox('myBox');
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode themeMode = ThemeMode.light;

  ColorSelection colorSelection = ColorSelection.teal;

  void changeThemeMode(bool useLightMode){
    setState(() {
      themeMode = useLightMode ? ThemeMode.light : ThemeMode.dark;
    });
  }

  void changeColor (int value){
    setState(() {
      colorSelection = ColorSelection.values[value];
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do List',
      themeMode: themeMode,
      theme: ThemeData(
        useMaterial3: false,
        colorSchemeSeed: colorSelection.color,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: colorSelection.color,
        useMaterial3: false,
        brightness: Brightness.dark
      ),
      home: Home(changeTheme: changeThemeMode),
    );
  }
}

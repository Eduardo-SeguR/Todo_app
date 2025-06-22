import 'package:flutter/material.dart';

enum ColorSelection{
  deepPurple(
      "Deep Purple",
      Colors.purple),
  purple("Purple", Colors.deepPurple),
  indigo("Indigo", Colors.indigo),
  blue("Blue", Colors.blue),
  teal("Teal", Colors.teal),
  green("Green", Colors.green),
  yellow("Yellow", Colors.yellow),
  pink("Pink", Colors.pink);

  final String nombre;
  final Color color;

  const ColorSelection(this.nombre, this.color);
}
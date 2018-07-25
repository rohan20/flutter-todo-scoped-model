import 'package:flutter/material.dart';
import 'package:flutter_todo_scoped_model/scoped_model/todos.dart';
import 'package:flutter_todo_scoped_model/pages/todos_page.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  runApp(
    new MaterialApp(
      home: ScopedModel(
        model: Todos(),
        child: TodosPage(),
      ),
    ),
  );
}

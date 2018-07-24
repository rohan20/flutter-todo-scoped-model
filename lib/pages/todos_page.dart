import 'package:flutter/material.dart';
import 'package:flutter_todo_scoped_model/model/todos.dart';
import 'package:scoped_model/scoped_model.dart';

class TodosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildTodos(),
    );
  }

  _buildTodos() {
    return ScopedModel<Todos>(
      model: Todos(),
      child: Container(
        color: Colors.yellow,
      ),
    );
  }
}

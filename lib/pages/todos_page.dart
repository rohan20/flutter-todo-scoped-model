import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_todo_scoped_model/model/todos.dart';
import 'package:flutter_todo_scoped_model/widget/todo_dialog.dart';
import 'package:flutter_todo_scoped_model/widget/todo_widget.dart';
import 'package:scoped_model/scoped_model.dart';

class TodosPage extends StatelessWidget {
  Todos model;
  BuildContext context;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<Todos>(
      builder: (context, child, todosModel) {
        this.context = context;
        this.model = todosModel;

        return Scaffold(
          appBar: AppBar(
            title: Text("Todo Scoped Model"),
          ),
          body: _buildTodosContent(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _buildDialogForNewTodo();
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }

  _buildTodosContent() {
    if (model == null || model.todos.isEmpty) {
      return _buildPlaceholderText();
    }

    return ListView.builder(
      itemCount: model.todosCount,
      itemBuilder: (context, index) {
        return TodoItem(model.todos[index], model);
      },
    );
  }

  _buildPlaceholderText() {
    return Container(
      margin: const EdgeInsets.all(
        20.0,
      ),
      child: Center(
        child: Text(
          "Press the FAB icon to add a new todo",
          style: Theme.of(context).textTheme.headline,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Future<Null> _buildDialogForNewTodo() async {
    await showDialog(
      context: context,
      builder: (context) {
        return TodoDialog(model);
      },
    );
  }
}

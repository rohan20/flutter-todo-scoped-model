import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_todo_scoped_model/model/to_do.dart';
import 'package:flutter_todo_scoped_model/model/todos.dart';
import 'package:scoped_model/scoped_model.dart';

class TodosPage extends StatelessWidget {
  Todos model;
  BuildContext context;
  TextEditingController titleTextController = TextEditingController();

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
        return _buildTodoItem(model.todos[index]);
      },
    );
  }

  _buildTodoItem(ToDo todo) {
    bool isChecked = model.isCheckedTodo(todo);

    return Dismissible(
      key: Key(todo.id.toString()),
      background: Container(
        color: Colors.red[300],
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) => model.removeTodo(todo),
      child: InkWell(
        onTap: () {
          model.toggleTodo(todo);
        },
        child: Container(
          padding: const EdgeInsets.all(12.0),
          color: isChecked ? Colors.green[100] : null,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              _buildTodoItemText(todo),
              _buildTodoItemIcon(todo),
            ],
          ),
        ),
      ),
    );
  }

  Future<Null> _buildDialogForNewTodo() async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(12.0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildDialogInputField(),
              _buildDialogButtons(),
            ],
          ),
        );
      },
    );
  }

  _buildAlertDialogCancelButton() {
    return Expanded(
      child: RaisedButton(
          color: Colors.white,
          child: Text("Cancel"),
          textColor: Colors.red,
          onPressed: () {
            titleTextController.clear();
            Navigator.of(context).pop();
          }),
    );
  }

  _buildAlertDialogAddButton() {
    return Expanded(
      child: RaisedButton(
          color: Colors.white,
          child: Text("Add"),
          textColor: Colors.green,
          onPressed: () {
            if (titleTextController.text.isNotEmpty) {
              model.addTodo(ToDo(titleTextController.text));
            }
            titleTextController.clear();

            Navigator.of(context).pop();
          }),
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

  _buildTodoItemText(ToDo todo) {
    return Flexible(
      fit: FlexFit.tight,
      flex: 1,
      child: Text(
        todo.title,
        style: Theme.of(context).textTheme.headline,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  _buildTodoItemIcon(ToDo todo) {
    return Icon(
      model.isCheckedTodo(todo) ? Icons.done : null,
      color: Colors.white,
      size: 40.0,
    );
  }

  _buildDialogInputField() {
    return TextField(
      autofocus: true,
      maxLines: 1,
      controller: titleTextController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Todo Title",
        hintText: "Eg: Buy eggs",
      ),
    );
  }

  _buildDialogButtons() {
    return Container(
      margin: const EdgeInsets.only(top: 12.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _buildAlertDialogCancelButton(),
          SizedBox(width: 12.0),
          _buildAlertDialogAddButton(),
        ],
      ),
    );
  }
}

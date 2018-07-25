import 'package:flutter/material.dart';
import 'package:flutter_todo_scoped_model/model/to_do.dart';
import 'package:flutter_todo_scoped_model/scoped_model/todos.dart';

class TodoDialog extends StatelessWidget {
  BuildContext context;
  final TextEditingController titleTextController = TextEditingController();
  final Todos model;

  TodoDialog(this.model);

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return _buildDialog();
  }

  _buildDialog() {
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
  }

  _buildDialogInputField() {
    return TextField(
      autofocus: true,
      maxLines: 1,
      controller: titleTextController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
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
          _buildDialogCancelButton(),
          SizedBox(width: 12.0),
          _buildDialogAddButton(),
        ],
      ),
    );
  }

  _buildDialogAddButton() {
    return Expanded(
      child: RaisedButton(
          splashColor: Colors.blue[100],
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

  _buildDialogCancelButton() {
    return Expanded(
      child: RaisedButton(
          splashColor: Colors.blue[100],
          color: Colors.white,
          child: Text("Cancel"),
          textColor: Colors.red,
          onPressed: () {
            titleTextController.clear();
            Navigator.of(context).pop();
          }),
    );
  }
}

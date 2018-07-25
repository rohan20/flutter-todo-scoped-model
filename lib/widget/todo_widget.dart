import 'package:flutter/material.dart';
import 'package:flutter_todo_scoped_model/model/to_do.dart';
import 'package:flutter_todo_scoped_model/scoped_model/todos.dart';

class TodoItem extends StatelessWidget {
  BuildContext context;
  final ToDo todo;
  final Todos model;

  TodoItem(this.todo, this.model);

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return _buildTodoItem(todo);
  }

  _buildTodoItem(ToDo todo) {
    bool isChecked = model.isCheckedTodo(todo);

    return Dismissible(
      key: Key(todo.id.toString()),
      background: Container(
        color: Colors.blue[300],
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) => model.removeTodo(todo),
      child: InkWell(
        onTap: () {
          model.toggleTodo(todo);
        },
        child: Container(
          padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
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
}

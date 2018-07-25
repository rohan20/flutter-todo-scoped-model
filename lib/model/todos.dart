import 'package:flutter_todo_scoped_model/model/to_do.dart';
import 'package:scoped_model/scoped_model.dart';

class Todos extends Model {
  List<ToDo> _todosList = [];
  Set<ToDo> _checkedTodos = Set<ToDo>();

  List<ToDo> get todos => _todosList;

  int get todosCount => _todosList.length;

  void addTodo(ToDo todo, {int position = 0}) {
    _todosList.insert(position, todo);
    notifyListeners();
  }

  /*
  Marks to-do as checked if it was unchecked and vice-versa
   */
  void toggleTodo(ToDo todo) {
    removeTodo(todo);

    if (_checkedTodos.contains(todo)) {
      _todosList.insert(0, todo);
      _checkedTodos.remove(todo);
    } else {
      _todosList.insert(_todosList.length, todo);
      _checkedTodos.add(todo);
    }

    notifyListeners();
  }

  void markTodoAsChecked(ToDo todo) {
    removeTodo(todo);
    _todosList.insert(_todosList.length, todo);
    _checkedTodos.add(todo);
    notifyListeners();
  }

  void markTodoAsUnchecked(ToDo todo) {
    removeTodo(todo);
    _todosList.insert(0, todo);
    _checkedTodos.remove(todo);
    notifyListeners();
  }

  void removeTodo(ToDo todo) {
    _todosList.remove(todo);
    notifyListeners();
  }
}

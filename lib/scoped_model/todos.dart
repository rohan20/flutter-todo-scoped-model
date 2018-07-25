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
    /*
    Remove to-do from current list because we'll re-add it to the top if it is 
    marked unchecked or re-add it to the bottom if it is marked as checked
     */
    removeTodo(todo);

    if (_checkedTodos.contains(todo)) {
      _markTodoAsUnchecked(todo);
    } else {
      _markTodoAsChecked(todo);
    }

    notifyListeners();
  }

  void _markTodoAsChecked(ToDo todo) {
    _todosList.insert(_todosList.length, todo);
    _checkedTodos.add(todo);
  }

  void _markTodoAsUnchecked(ToDo todo) {
    _todosList.insert(0, todo);
    _checkedTodos.remove(todo);
  }

  void removeTodo(ToDo todo) {
    _todosList.remove(todo);
    notifyListeners();
  }

  bool isCheckedTodo(ToDo todo) {
    return _checkedTodos.contains(todo);
  }
}

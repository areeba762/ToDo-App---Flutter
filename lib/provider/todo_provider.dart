import 'package:flutter/cupertino.dart';
import 'package:to_do_app/model/todo.dart';

class TodosProvider extends ChangeNotifier {
  List<Todo> todos = [];

  void addTaskInList(String title, String detail) {
    Todo todo = Todo(title, detail);
    todos.add(todo);
    notifyListeners();
  }
  void editTaskInList(int index, String newTitle, String newDetail) {
    if (index >= 0 && index < todos.length) {
      todos[index].edit(newTitle, newDetail);
      notifyListeners();
    }
  }

  void deleteTaskInList(int index) {
    if (index >= 0 && index < todos.length) {
      todos.removeAt(index);
      notifyListeners();
    }
  }


}
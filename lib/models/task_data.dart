import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:tasker/models/task.dart';
import 'dart:collection';

class TaskData extends ChangeNotifier {
  int counter;
  List<Task> _tasks = [
    Task(name: "Long press me to delete me! "),
  ];

  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView(_tasks);
  }

  int get taskCount {
    return _tasks.length;
  }

  void addTask(String newTaskTitle) {
    final task = Task(name: newTaskTitle);
    _tasks.add(task);
    notifyListeners();
  }

  void updateTask(Task task) {
    task.toggleDone();
    notifyListeners();
  }

  void deleteTask(Task task) {
    _tasks.remove(task);
    notifyListeners();
  }
}

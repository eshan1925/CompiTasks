import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tasker/Widgets/task_tile.dart';
import 'package:tasker/models/task.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tasker/screens/Login_Screen.dart';

final _auth = FirebaseAuth.instance;
final taskTextController = TextEditingController();
String taskText;
final _firestore = FirebaseFirestore.instance;
User loggedInUser;
List<TaskTile> _tasks = [];
List<TaskTile> _tasksUser = [];
int get taskCount {
  return _tasks.length;
}

// ignore: must_be_immutable
class TaskData extends StatelessWidget with ChangeNotifier {
  void updateTask(Task task) {
    task.toggleDone();
    notifyListeners();
  }

  void deleteTask(Task task) {
    _tasksUser.remove(task);
    notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      builder:
          // ignore: missing_return
          (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.blueAccent.shade400,
            ),
          );
        }
        final tasks = snapshot.data.docs.reversed;
        for (var message in tasks) {
          final messageText = message.data()['task'];
          final messageSender = message.data()['sender'];
          final currentUser = loggedInUser.email;
          final userId = loggedInUser.uid;
          final taskTile = TaskTile(
            task: messageText,
            sender: currentUser,
            userid: userId,
            longPressCallBack: () {
              messageText.deleteTask('task');
            },
            isChecked: messageText.isDone,
            checkboxCallBack: (bool checkBoxState) {
              messageText.updateTask(messageText);
            },
          );
          _tasks.add(taskTile);
        }
        _tasksUser = _tasks
            .where((element) => element.sender == selectedUserLog)
            .toList();
        return ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          reverse: true,
          children: _tasksUser,
        );
      },
      stream: _firestore.collection('task').orderBy('timestamp').snapshots(),
    );
  }
}

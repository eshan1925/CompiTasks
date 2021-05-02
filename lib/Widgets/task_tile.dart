import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('THis is a task.'),
      trailing: Checkbox(
        value: false,
      ),
    );
  }
}

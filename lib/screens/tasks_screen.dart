import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasker/Widgets/task_tile.dart';
import 'package:tasker/models/task_data.dart';
import 'package:tasker/screens/add_task_screen.dart';
import 'package:tasker/models/Side_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;
User loggedInUser;
final taskTextController = TextEditingController();
final _auth = FirebaseAuth.instance;
String taskText;

// ignore: must_be_immutable
class TasksScreen extends StatefulWidget {
  static const String id = 'Tasks_Screen';
  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      // ignore: await_only_futures
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  void getTasks() async {
    final messages = await _firestore.collection('Tasks').get();
    for (var message in messages.docs) {
      print(message.data());
    }
  }

  void taskStream() async {
    await for (var snapshot in _firestore.collection('Tasks').snapshots()) {
      for (var message in snapshot.docs) {
        print(message.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.transparent,
      ),
      drawer: SideMenu(),
      backgroundColor: Colors.lightBlueAccent,
      //beginning of addition button
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red.shade900,
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: AddTaskScreen(),
              ),
            ),
          );
        },
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding:
                  EdgeInsets.only(top: 60, left: 30, right: 30, bottom: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: CircleAvatar(
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("images/logo.jpeg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      backgroundColor: Colors.white,
                      radius: 70,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Tasks left for your boring life:',
                    style: GoogleFonts.girassol(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 50,
                          color: Colors.white),
                    ),
                  ),
                  Text(
                    ' $taskCount Tasks',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white54,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                ),
                child: TaskData(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

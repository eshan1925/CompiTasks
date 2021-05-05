import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasker/models/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tasker/screens/tasks_screen.dart';

final _firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;
User loggedInUser;

// ignore: must_be_immutable
class AddTaskScreen extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Center(
              child: Text(
                'Add Task',
                textAlign: TextAlign.center,
                style: GoogleFonts.girassol(
                  textStyle:
                      TextStyle(color: Colors.red.shade900, fontSize: 30),
                ),
              ),
            ),
            TextField(
              controller: taskTextController,
              onChanged: (value) {
                taskText = value;
              },
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              decoration:
                  kTextFieldDecoration.copyWith(hintText: 'Start typing...'),
            ),
            //ignore: deprecated_member_use
            SizedBox(
              height: 20,
            ),
            // ignore: deprecated_member_use
            FlatButton(
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0),
              ),
              child: Text(
                'Add',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              color: Colors.red.shade900,
              onPressed: () {
                taskTextController.clear();
                _firestore.collection('Tasks').add({
                  'task': taskText,
                  'sender': loggedInUser.email,
                  'timestamp': FieldValue.serverTimestamp(),
                  'userid': loggedInUser.uid,
                });
                Navigator.pushNamed(context, TasksScreen.id);
              },
            )
          ],
        ),
      ),
    );
  }
}

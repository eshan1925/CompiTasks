import 'package:flutter/material.dart';
import 'package:tasker/models/task_data.dart';
import 'package:tasker/screens/About.dart';
import 'package:tasker/screens/Intro.dart';
import 'package:tasker/screens/Login_Screen.dart';
import 'package:tasker/screens/Signup_Screen.dart';
import 'screens/tasks_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';

void main() async {
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    if (kReleaseMode) exit(1);
  };
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  // ignore: non_constant_identifier_names
  Widget SomethingWentWrong() {
    return Container(
      child: Text('Something went wrong'),
    );
  }

  // ignore: non_constant_identifier_names
  Widget Loading() {
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return SomethingWentWrong();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return Appcontroller();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Loading();
      },
    );
  }
}

class Appcontroller extends StatelessWidget {
  const Appcontroller({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WelcomeScreen(),
      routes: {
        AboutUs.id: (context) => AboutUs(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        WelcomeScreen.id: (context) => WelcomeScreen(),
        TasksScreen.id: (context) => TasksScreen(),
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasker/Widgets/tasks_list.dart';
import 'package:tasker/models/task_data.dart';
import 'package:tasker/screens/Intro.dart';
import 'package:tasker/screens/Login_Screen.dart';
import 'package:tasker/screens/Signup_Screen.dart';
import 'screens/tasks_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskData(),
      child: MaterialApp(
        home: WelcomeScreen(),
        routes: {
          LoginScreen.id: (context) => LoginScreen(),
          RegistrationScreen.id: (context) => RegistrationScreen(),
          TasksScreen.id: (context) => TasksScreen(),
        },
      ),
    );
  }
}

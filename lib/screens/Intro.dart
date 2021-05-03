import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasker/screens/Login_Screen.dart';
import 'package:tasker/screens/Signup_Screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:tasker/models/Rounded_button.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'Welcome_Screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset(
                      'images/logo.jpeg',
                      colorBlendMode: BlendMode.clear,
                    ),
                    height: 120.0,
                    width: 60,
                  ),
                ),
              ),
              SizedBox(height: 12),
              Row(
                children: <Widget>[
                  // ignore: deprecated_member_use
                  TypewriterAnimatedTextKit(
                    speed: Duration(milliseconds: 250),
                    textAlign: TextAlign.center,
                    text: ['      Compi-Tasks'],
                    textStyle: GoogleFonts.girassol(
                      textStyle: TextStyle(
                        color: Colors.lightBlueAccent,
                        fontSize: 45.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 48.0,
              ),
              RoundedButton(
                colour: Colors.blueAccent,
                onPressed: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                },
                title: 'Log-in',
              ),
              RoundedButton(
                colour: Colors.blueAccent,
                onPressed: () {
                  Navigator.pushNamed(context, RegistrationScreen.id);
                },
                title: 'Sign-up',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

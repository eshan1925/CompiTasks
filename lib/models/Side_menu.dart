import 'package:flutter/material.dart';
import 'package:tasker/screens/Login_Screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:tasker/screens/About.dart';
import 'package:google_fonts/google_fonts.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/drawer.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          children: <Widget>[
            // ignore: deprecated_member_use
            FlatButton(
              onPressed: null,
              child: Text(
                'Compi-Tasks',
                style: GoogleFonts.girassol(
                  textStyle: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
              child: Container(
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 35,
            ),
            // ignore: deprecated_member_use
            FlatButton(
              // ignore: unnecessary_statements
              onPressed: () {
                // ignore: unnecessary_statements
                (Navigator.pushNamed(context, AboutUs.id));
              },
              child: Text(
                'About Us',
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
            ),
            // ignore: deprecated_member_use
            FlatButton(
              onPressed: () => launch("https://forms.gle/Xi5F597HuWew5H1k7"),
              child: Text(
                'Rate Us',
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
            ),
            // ignore: deprecated_member_use
            FlatButton(
              onPressed: () => launch("mailto: eshan1925@gmail.com"),
              child: Text(
                'Contact Us',
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
            ),
            // ignore: deprecated_member_use
            FlatButton(
              onPressed: () {
                // ignore: unnecessary_statements
                (Navigator.pushNamed(context, LoginScreen.id));
              },
              child: Text(
                'Log Out',
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
            ),
            // ignore: deprecated_member_use
            FlatButton(
              onPressed: () =>
                  launch("https://www.linkedin.com/in/eshan-gupta-883383202/"),
              child: Text(
                'Linked In',
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

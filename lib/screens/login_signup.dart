import 'dart:ui';

import 'package:pipshub/authentication/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../config/pallete.dart';
import 'package:provider/provider.dart';

class LoginSignUpScreen extends StatefulWidget {
  const LoginSignUpScreen({Key? key}) : super(key: key);

  @override
  _LoginSignUpScreenState createState() => _LoginSignUpScreenState();
}

class _LoginSignUpScreenState extends State<LoginSignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      body: SafeArea(
        child: Container(
            padding: EdgeInsets.only(top: 60, right: 20, left: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width,
                    child: SvgPicture.asset(
                      "assets/images/register.svg",
                    ),
                  ),
                  Text(
                    "Welcome To PIPSHUB",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Palette.activeColor,
                      fontFamily: 'Kaushan',
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 16),
                    child: Center(
                      child: Text(
                        "Most of traders lose their money due to NEWS, NOT TRACKING THEIR TRADES AND KNOWLEDGE. \n In PIPSHUB, we solve such issues for you we provide \n Trade Tracking System, News Alert and Courses for different Strategies Such as ICT and BTMM \n Get Started below with your Google Account",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    // SizedBox(height: 3),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Center(
                      child: TextButtonMethod(FontAwesomeIcons.googlePlus,
                          "Google", Palette.googleColor),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  TextButton TextButtonMethod(
    IconData icon,
    String text,
    Color backgroundColor,
  ) {
    return TextButton(
      onPressed: () {
        context.read<AuthenticationService>().signInWithGoogle();
      },
      style: TextButton.styleFrom(
        side: BorderSide(width: 1, color: Colors.grey),
        // minimumSize: Size(155, 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        primary: Colors.white,
        backgroundColor: backgroundColor,
      ),
      child: Row(
        children: [Icon(icon), SizedBox(width: 20), Text(text)],
      ),
    );
  }
}

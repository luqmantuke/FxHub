import 'package:firebaseauth/authentication.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../config/pallete.dart';
import 'package:provider/provider.dart';

class LoginSignUpScreen extends StatefulWidget {
  const LoginSignUpScreen({Key? key}) : super(key: key);

  @override
  _LoginSignUpScreenState createState() => _LoginSignUpScreenState();
}

class _LoginSignUpScreenState extends State<LoginSignUpScreen> {
  bool isSignupScreen = true;
  bool isGoogle = true;

  bool isRememberMe = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Palette.backgroundColor,
        body: Stack(
      children: [
        Positioned(
          top: 0,
          right: 0,
          left: 0,
          child: Container(
            height: 300,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background.jpg"),
                fit: BoxFit.fill,
              ),
            ),
            child: Container(
                padding: EdgeInsets.only(top: 90, left: 20),
                color: Palette.facebookColor.withOpacity(.85),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                          text: isSignupScreen ? "Welcome To" : "Welcome",
                          style: TextStyle(
                            letterSpacing: 2,
                            fontSize: 25,
                            color: Colors.yellow[700],
                          ),
                          children: [
                            TextSpan(
                              text: isSignupScreen ? " ForexTracker" : " Back",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.yellow[700],
                              ),
                            ),
                          ]),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      isSignupScreen
                          ? "SignUp To Continue"
                          : "SignIn To Continue",
                      style: TextStyle(
                        letterSpacing: 1,
                        color: Colors.white,
                      ),
                    )
                  ],
                )),
          ),
        ),
        // Main container for signup and login

        Positioned(
          top: 200,
          child: Container(
              padding: EdgeInsets.all(20),
              height: isSignupScreen ? 380 : 280,
              width: MediaQuery.of(context).size.width - 40,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 15,
                      spreadRadius: 5,
                    )
                  ]),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isSignupScreen = false;
                          });
                        },
                        child: Column(
                          children: [
                            Text(
                              "LOGIN",
                              style: TextStyle(
                                color: !isSignupScreen
                                    ? Palette.activeColor
                                    : Palette.textColor1,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (!isSignupScreen)
                              Container(
                                height: 2,
                                width: 55,
                                color: Colors.orange,
                              )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isSignupScreen = true;
                          });
                        },
                        child: Column(
                          children: [
                            Text(
                              "SIGNUP",
                              style: TextStyle(
                                color: isSignupScreen
                                    ? Palette.activeColor
                                    : Palette.textColor1,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (isSignupScreen)
                              Container(
                                margin: EdgeInsets.only(top: 3),
                                height: 2,
                                width: 55,
                                color: Colors.orange,
                              )
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (isSignupScreen) BuildSignupScreen(),
                  if (!isSignupScreen)
                    Container(
                      margin: EdgeInsets.only(top: 30),
                      child: Column(
                        children: [
                          BuildTextField(Icons.email_outlined, "Email", true,
                              false, emailController),
                          SizedBox(
                            height: 8,
                          ),
                          BuildTextField(Icons.password_outlined, "Password",
                              false, true, passwordController),
                        ],
                      ),
                    )
                ],
              )),
        ),
        // Trick to add submit button
        Positioned(
            top: isSignupScreen ? 535 : 435,
            right: 0,
            left: 0,
            child: Center(
              child: Container(
                padding: EdgeInsets.all(15),
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.orange, Colors.red],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.arrow_forward),
                    color: Colors.white,
                    onPressed: () {
                      if (isSignupScreen) {
                        context.read<AuthenticationService>().signUp(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                            );
                      } else {
                        context.read<AuthenticationService>().signIn(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                            );
                      }
                    },
                  ),
                ),
              ),
            )),
        // Position for 3rd Party Signup
        Positioned(
            top: MediaQuery.of(context).size.height - 150,
            right: 0,
            left: 0,
            child: Column(
              children: [
                Text(isSignupScreen ? "Or Signup With" : "Or Signn With"),
                Container(
                  margin: EdgeInsets.only(right: 20, left: 20, top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButtonMethod(Icons.facebook, "Facebook",
                          Palette.facebookColor, false),
                      TextButtonMethod(FontAwesomeIcons.googlePlusG, "Google",
                          Palette.googleColor, true)
                    ],
                  ),
                )
              ],
            )),
      ],
    ));
  }

  Container BuildSignupScreen() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: BuildTextField(
                Icons.email_outlined, "Email", true, false, emailController),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: BuildTextField(Icons.password_outlined, "Password", false,
                true, passwordController),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: BuildTextField(Icons.password_outlined, "Comfirm Password",
                false, true, passwordController),
          ),
          Container(
            width: 200,
            margin: EdgeInsets.only(top: 20),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: "By pressing 'Submit' you agree to our ",
                  style: TextStyle(
                    color: Palette.textColor1,
                  ),
                  children: [
                    TextSpan(
                      text: "Term and Conditions",
                      style: TextStyle(
                        color: Colors.orange,
                      ),
                    )
                  ]),
            ),
          ),
        ],
      ),
    );
  }

  TextButton TextButtonMethod(
      IconData icon, String text, Color backgroundColor, bool isGoogle) {
    return TextButton(
      onPressed: () {
        if (isGoogle) {
          context.read<AuthenticationService>().signInWithGoogle();
        }
      },
      style: TextButton.styleFrom(
        side: BorderSide(width: 1, color: Colors.grey),
        minimumSize: Size(155, 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        primary: Colors.white,
        backgroundColor: backgroundColor,
      ),
      child: Row(
        children: [Icon(icon), SizedBox(width: 5), Text(text)],
      ),
    );
  }

  TextField BuildTextField(IconData icons, String hintText, bool isEmail,
      bool isPassword, TextEditingController controller) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      decoration: InputDecoration(
        icon: Icon(icons, color: Palette.iconColor),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Palette.textColor1),
          borderRadius: BorderRadius.all(
            Radius.circular(35),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Palette.textColor1),
          borderRadius: BorderRadius.all(
            Radius.circular(35),
          ),
        ),
        contentPadding: EdgeInsets.all(10),
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 15,
          color: Palette.textColor1,
        ),
      ),
    );
  }
}

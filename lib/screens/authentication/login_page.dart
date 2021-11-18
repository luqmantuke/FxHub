import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pipshub/authentication/authentication.dart';
import 'package:pipshub/screens/authentication/register_page.dart';
import 'package:pipshub/screens/homepage.dart';
import 'package:pipshub/utils/contants.dart';
import 'package:pipshub/utils/theme.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool passwordVisible = false;
  bool passwordConfrimationVisible = false;
  bool isLoading = false;
  bool isGoogle = true;
  final TextEditingController _email = new TextEditingController();
  final TextEditingController _passwordComfirm = new TextEditingController();
  void togglePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(24.0, 40.0, 24.0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Login To Your\nAccount',
                      style: heading2.copyWith(color: textBlack),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
                SizedBox(
                  height: 48,
                ),
                Form(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: textWhiteGrey,
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        child: TextFormField(
                          controller: _email,
                          decoration: InputDecoration(
                            hintText: 'Email',
                            hintStyle: heading6.copyWith(color: textGrey),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),

                      // Container(
                      //   decoration: BoxDecoration(
                      //     color: textWhiteGrey,
                      //     borderRadius: BorderRadius.circular(14.0),
                      //   ),
                      //   child: TextFormField(
                      //     obscureText: !passwordVisible,
                      //     controller: _password,
                      //     decoration: InputDecoration(
                      //       hintText: 'Password',
                      //       hintStyle: heading6.copyWith(color: textGrey),
                      //       suffixIcon: IconButton(
                      //         color: textGrey,
                      //         splashRadius: 1,
                      //         icon: Icon(passwordVisible
                      //             ? Icons.visibility_outlined
                      //             : Icons.visibility_off_outlined),
                      //         onPressed: togglePassword,
                      //       ),
                      //       border: OutlineInputBorder(
                      //         borderSide: BorderSide.none,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                        height: 32,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: textWhiteGrey,
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        child: TextFormField(
                          obscureText: !passwordConfrimationVisible,
                          controller: _passwordComfirm,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: heading6.copyWith(color: textGrey),
                            suffixIcon: IconButton(
                              color: textGrey,
                              splashRadius: 1,
                              icon: Icon(passwordConfrimationVisible
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined),
                              onPressed: () {
                                setState(() {
                                  passwordConfrimationVisible =
                                      !passwordConfrimationVisible;
                                });
                              },
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                SizedBox(
                  height: 32,
                ),
                InkWell(
                  onTap: isLoading == true && isGoogle == false
                      ? null
                      : () async {
                          setState(() {
                            isLoading = true;
                          });
                          final result = await context
                              .read<AuthenticationService>()
                              .signIn(
                                email: _email.text,
                                password: _passwordComfirm.text,
                              );
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              result,
                              style: TextStyle(fontSize: 16),
                            ),
                          ));
                          if (result == "SignedIn") {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()));
                          }
                          setState(() {
                            isLoading = false;
                          });
                        },
                  child: Center(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                      decoration: BoxDecoration(
                          color: kblue,
                          borderRadius: BorderRadius.circular(15.0)),
                      child: isLoading == true
                          ? Center(child: CircularProgressIndicator())
                          : Row(mainAxisSize: MainAxisSize.min, children: [
                              Text(
                                "Login",
                                style: TextStyle(fontSize: 16.0, color: kwhite),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.02,
                              ),
                              Icon(
                                Icons.arrow_forward_sharp,
                                color: kwhite,
                              )
                            ]),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                InkWell(
                  onTap: isLoading == true && isGoogle
                      ? null
                      : () async {
                          setState(() {
                            isLoading = true;
                          });
                          await context
                              .read<AuthenticationService>()
                              .signInWithGoogle();

                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              "Welcome OnBoard :)",
                              style: TextStyle(fontSize: 16),
                            ),
                          ));
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                          setState(() {
                            isLoading = false;
                          });
                        },
                  child: Center(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                      decoration: BoxDecoration(
                          color: googleColor,
                          borderRadius: BorderRadius.circular(15.0)),
                      child: isLoading == true
                          ? Center(child: CircularProgressIndicator())
                          : Row(mainAxisSize: MainAxisSize.min, children: [
                              Text(
                                "Continue With Google",
                                style: TextStyle(fontSize: 16.0, color: kwhite),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.02,
                              ),
                              Icon(
                                FontAwesomeIcons.googlePlusG,
                                color: kwhite,
                              )
                            ]),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Doesn't have an account? ",
                      style: regular16pt.copyWith(color: textGrey),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterPage()));
                      },
                      child: Text(
                        'Register',
                        style: regular16pt.copyWith(color: primaryBlue),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

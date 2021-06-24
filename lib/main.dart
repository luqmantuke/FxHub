import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseauth/authentication.dart';
import 'package:firebaseauth/screens/login_signup.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return MultiProvider(
    //   providers: [
    //     Provider<AuthenticationService>(
    //       create: (_) => AuthenticationService(FirebaseAuth.instance),
    //     ),
    //     StreamProvider(
    //         create: (context) =>
    //             context.read<AuthenticationService>().authStateChanges,
    //         initialData: null)
    //   ],
    //   child: MaterialApp(
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: LoginSignUpScreen(),
    );
  }
}

// class AuthenticationWrapper extends StatelessWidget {
//   const AuthenticationWrapper({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final firebaseUser = context.watch<User>();
//     if (firebaseUser != null) {
//       return Text("Signed in");
//     }
//     return Text("Not Signed in");
//   }
// }

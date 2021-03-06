import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  AuthenticationService(FirebaseAuth instance);

  Stream<String> get authStateChanges =>
      _auth.authStateChanges().map((User? user) => user!.uid);

  //SIGN UP METHOD
  Future signUp({required String email, required String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return "SignedUp";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SIGN IN METHOD
  Future signIn({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return "SignedIn";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // SIGNIN WITH GOOGLE

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  // SIGNOUT METHOD
  Future signOut() async {
    await _auth.signOut();
  }

  // GET CURRENT UID
  String getCurrentUID() {
    return FirebaseAuth.instance.currentUser!.uid;
  }

  // GET CURRENT USERNAME
  String getCurrentUname() {
    return FirebaseAuth.instance.currentUser!.displayName.toString();
  }
}

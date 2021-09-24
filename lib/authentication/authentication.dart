import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  AuthenticationService(FirebaseAuth instance);

  Stream<String> get authStateChanges =>
      _auth.authStateChanges().map((User? user) => user!.uid);

  // SIGNIN WITH GOOGLE

  Future<String?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      print(e.message);
      throw e;
    }
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

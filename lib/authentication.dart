import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthenticationService(FirebaseAuth instance);

  Stream<String> get authStateChanges =>
      _auth.authStateChanges().map((User? user) => user!.uid);

  // SIGNUP METHOD
  Future signUp({required String email, required String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return 'Signed up';
    } on FirebaseAuthException catch (error) {
      return error.message;
    }
  }

  // SIGNIN METHOD
  Future signIn({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return 'Signed In';
    } on FirebaseAuthException catch (error) {
      return error.message;
    }
  }

  // SIGNIN WITH GOOGLE

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

//   // SIGNIN WITH FACEBOOK

//     Future<UserCredential> signInWithFacebook() async {
//   // Trigger the sign-in flow
//   final LoginResult result = await FacebookAuth.instance.login();

//   // Create a credential from the access token
//   final facebookAuthCredential = FacebookAuthProvider.credential(String?).idToken;

//   // Once signed in, return the UserCredential
//   return await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
// }
  // SIGNOUT METHOD
  Future signOut() async {
    await _auth.signOut();
    print('Signout');
  }
}

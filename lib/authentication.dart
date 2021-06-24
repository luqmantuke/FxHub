import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthenticationService(FirebaseAuth instance);

  Stream<String> get authStateChanges =>
      _auth.authStateChanges().map((User? user) => user!.uid);

  // SIGNUP METHOD
  Future singUp({required String email, required String password}) async {
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

  // SIGNOUT METHOD
  Future signOut() async {
    await _auth.signOut();
    print('Signout');
  }
}

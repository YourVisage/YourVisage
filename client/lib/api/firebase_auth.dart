import 'dart:io';

import 'package:client/router/router_path.dart';
import 'package:client/static/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  AuthenticationService(
    this._firebaseAuth,
    this._googleSignIn,
  );
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<String> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      Navkey.navkey.currentState?.pushNamed(RouterPath.home, arguments: {});
      return 'Sign in';
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }

  Future<String> signUp({required String email, required String password, required String username, required String rePassword, File? initialImage}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      Navkey.navkey.currentState?.pushNamed(RouterPath.home, arguments: {
        'initialImage': initialImage,
      });
      return 'Sign up';
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }

  Future<String> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      print(googleSignInAccount);
      if (googleSignInAccount != null) {
        // print('object');

        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        await _firebaseAuth.signInWithCredential(credential);
        return 'Sign in with Google';
      } else {
        // print('object');
        return 'Google Sign-In Cancelled';
      }
    } catch (e) {
      print('error handling $e');
      return e.toString();
    }
  }

  Future<void> signout() async {
    await _firebaseAuth.signOut();
    Navkey.navkey.currentState?.pushNamedAndRemoveUntil(RouterPath.onboardingPage, (route) => false);
  }
}

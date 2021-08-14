import 'package:chat_app/pages/home_page.dart';
import 'package:chat_app/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class FirebaseAuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static User? get currentUser => _auth.currentUser;

  static Future<User?> loginUser(
      {required String email, required String pass}) async {
    User? user;
    final UserCredential userCredential =
        await _auth.signInWithEmailAndPassword(email: email, password: pass);
    user = userCredential.user;
    return user;
  }

  static Future<User?> registerUser(String email, String pass) async {
    final result = await _auth.createUserWithEmailAndPassword(
        email: email, password: pass);
    return result.user;
  }

  static Future<void> logoutUser({required BuildContext context}) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      if (!kIsWeb) {
        await googleSignIn.signOut();
      }
      await _auth.signOut();
      Navigator.pushReplacementNamed(context, LoginPage.routeName);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        customSnackBar(
          content: 'Error signing out. Try again.',
        ),
      );
    }
  }

  static Future<FirebaseApp> initializeFirebase(
      {required BuildContext context}) async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    //User? user = _auth.currentUser;
    if (_auth.currentUser != null) {
      //Navigator.of(context).pushReplacement(
      //  MaterialPageRoute(
      //    builder: (context) => UserInfoScreen(
      //      user: user,
      //    ),
      //  ),
      //);
      //Navigator.pushReplacementNamed(context, ChatRoomPage.routeName);
      Navigator.pushReplacementNamed(context, HomePage.routeName);
    }

    return firebaseApp;
  }

  static Future<User?> signInWithGoogle({required BuildContext context}) async {
    User? user;

    if (kIsWeb) {
      GoogleAuthProvider authProvider = GoogleAuthProvider();

      try {
        final UserCredential userCredential =
            await _auth.signInWithPopup(authProvider);
        user = userCredential.user;
      } catch (e) {
        print(e);
      }
    } else {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        try {
          final UserCredential userCredential =
              await _auth.signInWithCredential(credential);
          user = userCredential.user;
        } on FirebaseAuthException catch (e) {
          if (e.code == 'account-exists-with-different-credential') {
            ScaffoldMessenger.of(context).showSnackBar(
              customSnackBar(
                  content:
                      'The account already exists with a different credential.'),
            );
          } else if (e.code == 'invalid-credential') {
            ScaffoldMessenger.of(context).showSnackBar(
              customSnackBar(
                  content:
                      'Error occurred while accessing credentials. Try again.'),
            );
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            customSnackBar(
                content: 'Error occurred using Google Sign-In. Try again.'),
          );
        }
      }
    }
    return user;
  }

  static SnackBar customSnackBar({required String content}) {
    return SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        content,
        style: TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
      ),
    );
  }
}

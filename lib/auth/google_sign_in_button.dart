import 'package:chat_app/pages/chat_room_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'firebase_auth_service.dart';

class GoogleSignInButton extends StatefulWidget {
  @override
  _GoogleSignInButtonState createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  bool _isGoogleSigningIn = false;
  String errorMsg = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: _isGoogleSigningIn ?
          const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white)
          ) : OutlinedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)
                      )
                  ),
                ),
        onPressed: () async {
          setState(() {
            _isGoogleSigningIn = true;
          });

            User? user = await FirebaseAuthService.signInWithGoogle(context: context);
          if (user != null) {
            Navigator.pushReplacementNamed(context, ChatRoomPage.routeName);
          }

          //String? uid;
          //uid = await FirebaseAuthService.signInWithGoogle(context: context);

          setState(() {
            _isGoogleSigningIn = false;
          });
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Image(
              image: AssetImage("images/google_logo.png"),
              height: 35.0,
            ),
        )
      ),
    );
  }
}
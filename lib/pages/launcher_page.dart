import 'package:chat_app/auth/firebase_auth_service.dart';
import 'package:chat_app/pages/chat_room_page.dart';
import 'package:chat_app/pages/login_page.dart';
import 'package:flutter/material.dart';

class LauncherPage extends StatefulWidget {
  static final String routeName = "\launcher";

  @override
  _LauncherPageState createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {

  @override
  void initState() {
    Future.delayed(Duration.zero,() {
      if(FirebaseAuthService.currentUser != null){
        Navigator.pushReplacementNamed(context, ChatRoomPage.routeName);
      }else{
        Navigator.pushReplacementNamed(context, LoginPage.routeName);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'images/launcher_icon.png',
            height: 250,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Welcome to --- !',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 28),
          ),
          SizedBox(height: 20),
          Text(
            'Team Chat Application',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }
}

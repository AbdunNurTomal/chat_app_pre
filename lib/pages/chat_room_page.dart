import 'package:chat_app/auth/firebase_auth_service.dart';
import 'package:chat_app/pages/login_page.dart';
import 'package:flutter/material.dart';

class ChatRoomPage extends StatefulWidget {
  static const String routeName = "\chat_room";

  @override
  _ChatRoomPageState createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Room'),
        actions: [
          IconButton(
              onPressed: (){
                FirebaseAuthService.logoutUser(context: context);
                Navigator.pushReplacementNamed(context, LoginPage.routeName);
              },
              icon: const Icon(Icons.logout)
          )
        ],
      ),
      body: const Center(
        child: Text('Chat Room'),
      ),
    );
  }
}

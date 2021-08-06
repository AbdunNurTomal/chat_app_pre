import 'package:flutter/material.dart';

class ChatRoomPage extends StatefulWidget {
  static final String routeName = "\chat_room";

  @override
  _ChatRoomPageState createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Chat Room'),
      ),
    );
  }
}

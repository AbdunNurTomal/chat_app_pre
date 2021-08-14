import 'package:chat_app/auth/firebase_auth_service.dart';
import 'package:chat_app/component/side_menu.dart';
import 'package:chat_app/login_page.dart';
import 'package:chat_app/pages/message/message_header_bar.dart';
import 'package:chat_app/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ChatRoomPage extends StatefulWidget {
  static const String routeName = "\chat_room";

  @override
  _ChatRoomPageState createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Chat Room'),
          actions: [
            IconButton(
                onPressed: () {
                  FirebaseAuthService.logoutUser(context: context);
                  Navigator.pushReplacementNamed(context, LoginPage.routeName);
                },
                icon: const Icon(Icons.logout))
          ],
        ),
        key: _scaffoldKey,
        drawer: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 250),
          child: SideMenu(),
        ),
        body: Container(
          padding: EdgeInsets.only(top: kIsWeb ? kDefaultPadding : 0),
          color: kBgDarkColor,
          child: SafeArea(
            right: false,
            child: Column(children: [
              // This is our Header bar
              MessageHeaderBar(scaffoldKey: _scaffoldKey),

              SizedBox(height: kDefaultPadding),
              Text('Chat Room Page')
            ]),
          ),
        ));
  }
}

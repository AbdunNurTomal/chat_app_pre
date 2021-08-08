import 'package:chat_app/pages/chat_room_page.dart';
import 'package:chat_app/pages/launcher_page.dart';
import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/pages/user_profile_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: LauncherPage(),
      routes:{
        LauncherPage.routeName : (context)=> LauncherPage(),
        LoginPage.routeName : (context)=> LoginPage(),
        ChatRoomPage.routeName : (context)=> ChatRoomPage(),
        UserProfilePage.routeName : (context)=> UserProfilePage(),
      }
    );
  }
}
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'auth/auth_dialog.dart';
import 'launcher_page.dart';
import 'auth/login_page.dart';
import 'pages/message/message_home_page.dart';
//import 'pages/users/user_profile_page.dart';
import 'pages/weather/weather_page.dart';
import 'welcome_page.dart';
//import 'auth/auth_dialog.dart';

void main() async {
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
        title: 'Experiment',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        home: LauncherPage(),
        routes: {
          LauncherPage.routeName: (context) => LauncherPage(),
          WelcomePage.routeName: (context) => WelcomePage(),
          LoginPage.routeName: (context) => LoginPage(),
          AuthDialog.routeName: (context) => AuthDialog(),
          MessageHomePage.routeName: (context) => MessageHomePage(),
          WeatherPage.routeName: (context) => WeatherPage(),
        });
  }
}

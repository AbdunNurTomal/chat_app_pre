import 'package:flutter/material.dart';

import 'auth/auth_dialog.dart';
import 'auth/firebase_auth_service.dart';
import 'auth/login_page.dart';
import 'utils/responsive_screen.dart';
import 'welcome_page.dart';

class LauncherPage extends StatefulWidget {
  static const String routeName = "\launcher";

  @override
  _LauncherPageState createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () {
      if (FirebaseAuthService.currentUser != null) {
        Navigator.pushReplacementNamed(context, WelcomePage.routeName);
      } else {
        if (Responsive.isDesktop(context) || Responsive.isTablet(context)) {
          Navigator.pushReplacementNamed(context, AuthDialog.routeName);
        } else {
          Navigator.pushReplacementNamed(context, LoginPage.routeName);
        }
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
        const SizedBox(height: 20),
        const Text(
          'Welcome to --- !',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 28),
        ),
        const SizedBox(height: 20),
        const Text(
          'Team Chat Application',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        const SizedBox(height: 30),
        const Center(
          child: CircularProgressIndicator(),
        ),
      ],
    ));
  }
}

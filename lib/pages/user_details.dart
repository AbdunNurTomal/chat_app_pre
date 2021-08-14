import 'package:flutter/material.dart';

class UserDetailsScreen extends StatefulWidget {
  //const UserDetails({Key? key}) : super(key: key);
  static const String routeName = "\details_page";

  @override
  _UserDetailsStateScreen createState() => _UserDetailsStateScreen();
}

class _UserDetailsStateScreen extends State<UserDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
      ),
    );
  }
}

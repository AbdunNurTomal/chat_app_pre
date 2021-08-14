import 'package:flutter/material.dart';

class ListOfUsersScreen extends StatefulWidget {
  //const ListOfUsersScreen({Key? key}) : super(key: key);
  static const String routeName = "\list_of_users";

  @override
  _ListOfUsersStateScreen createState() => _ListOfUsersStateScreen();
}

class _ListOfUsersStateScreen extends State<ListOfUsersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users List'),
      ),
    );
  }
}

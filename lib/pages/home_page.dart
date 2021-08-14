import 'package:chat_app/component/side_menu.dart';
import 'package:chat_app/pages/user_details.dart';
import 'package:chat_app/utils/responsive_screen.dart';
import 'package:flutter/material.dart';

import 'llist_of_users.dart';

class HomePage extends StatefulWidget {
  //const HomePage({Key? key}) : super(key: key);
  static const String routeName = "\home_page";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: Responsive(
        mobile: ListOfUsersScreen(),
        tablet: Row(
          children: [
            Expanded(
              flex: 6,
              child: ListOfUsersScreen(),
            ),
            Expanded(
              flex: 9,
              child: UserDetailsScreen(),
            ),
          ],
        ),
        desktop: Row(
          children: [
            // Once our width is less then 1300 then it start showing errors
            // Now there is no error if our width is less then 1340
            Expanded(
              flex: _size.width > 1340 ? 2 : 4,
              child: SideMenu(),
            ),
            Expanded(
              flex: _size.width > 1340 ? 3 : 5,
              child: ListOfUsersScreen(),
            ),
            Expanded(
              flex: _size.width > 1340 ? 8 : 10,
              child: UserDetailsScreen(),
            ),
          ],
        ),
      ),
    );
  }
}

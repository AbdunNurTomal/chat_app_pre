import 'package:chat_app/component/side_menu.dart';
import 'package:chat_app/pages/list_header_scrren.dart';
import 'package:chat_app/utils/constants.dart';
import 'package:chat_app/utils/responsive_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

class ListScreen extends StatefulWidget {
  //const ListOfUsersScreen({Key? key}) : super(key: key);
  static const String routeName = "\list_of_users";

  @override
  _ListStateScreen createState() => _ListStateScreen();
}

class _ListStateScreen extends State<ListScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          child: Column(
            children: [
              // This is our Seearch bar
              ListHeaderScrren(scaffoldKey: _scaffoldKey),
              SizedBox(height: kDefaultPadding),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: Row(
                  children: [
                    WebsafeSvg.asset(
                      "assets/Icons/Angle down.svg",
                      width: 16,
                      color: Colors.black,
                    ),
                    SizedBox(width: 5),
                    Text(
                      "Sort by date",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Spacer(),
                    MaterialButton(
                      minWidth: 20,
                      onPressed: () {},
                      child: WebsafeSvg.asset(
                        "assets/Icons/Sort.svg",
                        width: 16,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: kDefaultPadding),
              //Expanded(
              //  child: ListView.builder(
              //    itemCount: emails.length,
              //    // On mobile this active dosen't mean anything
              //    itemBuilder: (context, index) => EmailCard(
              //      isActive: Responsive.isMobile(context) ? false : index == 0,
              //      email: emails[index],
              //      press: () {
              //        Navigator.push(
              //          context,
              //          MaterialPageRoute(
              //            builder: (context) =>
              //                EmailScreen(email: emails[index]),
              //          ),
              //        );
              //      },
              //    ),
              //  ),
              //),
            ],
          ),
        ),
      ),
    );
  }
}

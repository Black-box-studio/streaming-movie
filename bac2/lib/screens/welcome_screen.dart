import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:panel_back_end/screens/about_us.dart';
import 'package:panel_back_end/screens/upload_categories_studios.dart';
import 'package:panel_back_end/screens/upload_editor_recommended.dart';
import 'package:panel_back_end/screens/upload_movies_page.dart';
import 'package:panel_back_end/screens/upload_series.dart';
import 'package:panel_back_end/screens/upload_shows.dart';
import 'package:panel_back_end/screens/upload_the_top.dart';
import 'package:panel_back_end/screens/upload_update.dart';

import 'package:panel_back_end/widgets/drawer.dart';

import '../constants.dart';
import 'dashboard_page.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int indexPage = 0;

  List<Widget> mListPages = [
    DashboardPage(),
    UploadMovies(),
    UploadSeries(),
    UploadShows(),
    UploadEditorAndRecommended(isEditor: true),
    UploadTheTop(),
    UploadCategoriesAndStudios(),
    UploadCategoriesAndStudios(isCategory: false),
    UploadUpdate(),
    AboutUs(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorGrey01,
      appBar: AppBar(
        title: Row(
          children: [
            Image(
              image: AssetImage('assets/images/icon.png'),
              width: 30.0,
              height: 30.0,
            ),
            SizedBox(width: 10.0),
            Text(kName, style: TextStyle(fontSize: 16.0)),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              FontAwesomeIcons.signOutAlt,
              color: Colors.white,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Row(
        children: [
          DrawerMain(
            index: indexPage,
            indexPage: (index) {
              setState(() {
                indexPage = index;
              });
            },
          ),
          Expanded(
            child: mListPages[indexPage],
          ),
        ],
      ),
    );
  }
}

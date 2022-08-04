import 'package:azul_movies/models/database.dart';
import 'package:azul_movies/models/notification.dart';
import 'package:azul_movies/screens/main/browse_screen.dart';
import 'package:azul_movies/screens/main/favorite_screen.dart';
import 'package:azul_movies/screens/main/home_screen.dart';
import 'package:azul_movies/screens/main/settings_screen.dart';
import 'package:azul_movies/widgets/widgets_main.dart';
import 'package:custom_navigator/custom_navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

GlobalKey<NavigatorState> mainNavigatorKey = GlobalKey<NavigatorState>();

class _WelcomeScreenState extends State<WelcomeScreen> {
  int indexPages = 0;

  changeIndexPage(index) {
    mainNavigatorKey.currentState.maybePop();
    setState(() {
      indexPages = index;
    });
  }

  List<Widget> mListScreensMain = [
    HomeScreen(),
    BrowseScreen(),
    FavoriteScreen(),
    SettingsScreen(),
  ];

  @override
  void initState() {
    NotificationsHandler.getMessages(context: context);
    Database.checkUpdateApp(context, isMain: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // debugPrint('Size = ' + MediaQuery.of(context).size.toString());

    return Scaffold(
      body: Stack(
        children: [
          CustomNavigator(
            navigatorKey: mainNavigatorKey,
            home: mListScreensMain[indexPages],
            pageRoute: PageRoutes.materialPageRoute,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CardBottomNav(
              list: [
                CardTabNav(
                  isSelected: indexPages == 0,
                  label: getTranslationText(context, 'home'),
                  icon: FontAwesomeIcons.home,
                  onPress: () => changeIndexPage(0),
                ),
                CardTabNav(
                  isSelected: indexPages == 1,
                  label: getTranslationText(context, 'browse'),
                  icon: FontAwesomeIcons.compass,
                  onPress: () => changeIndexPage(1),
                ),
                CardTabNav(
                  isSelected: indexPages == 2,
                  label: getTranslationText(context, 'favorite'),
                  icon: FontAwesomeIcons.heart,
                  onPress: () => changeIndexPage(2),
                ),
                CardTabNav(
                  isSelected: indexPages == 3,
                  label: getTranslationText(context, 'settings'),
                  icon: FontAwesomeIcons.cog,
                  onPress: () => changeIndexPage(3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

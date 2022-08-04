import 'package:flutter/material.dart';
import 'localization/demo_localization.dart';

// App Name
const String kAppName = 'Azul Movies';

// IF demo app
const bool kDemoApp = true;

// Active notification in the app ( note: need to link app with Functions firebase )
const bool kActiveNotification = true;

///All Colors App
const kColorBlack01 = Color(0xff000000);
const kColorBlack02 = Color(0xff111111);
const kColorBlack03 = Color(0xff262626);
const kColorBlack04 = Color(0xff676767);
const kColorBlack05 = Color(0xff3B3B3B);
const kColorGrey01 = Color(0xffB7B7B7);
const kColorRed01 = Color(0xffE8505B);
const kColorOrange01 = Color(0xFFEF6C00);

// max posts Lists Home Page
const int kMaxPostCarousel = 7;
const int kMaxPostMovies = 5;
const int kMaxPostRecommends = 7;
const int kMaxPostsMoviesBottomHome = 7;

///Image All Categories link
const kAllCategoriesLinkImage =
    'https://s.studiobinder.com/wp-content/uploads/2019/08/Best-Zombie-Movies-of-All-Time-StudioBinder.jpg';
const kImageAllMovies =
    "https://firebasestorage.googleapis.com/v0/b/azul-movies-63121.appspot.com/o/Characters%2FGroup%2087.png?alt=media&token=0fcd1e24-bf93-4b76-8b76-836b5343fc21";

// Change this Links to yours
const kLinkInstagram = 'https://www.instagram.com/azul_mouad/';
const kLinkFacebook = 'https://www.instagram.com/azul_mouad/';
const kLinkTwitter = 'https://www.instagram.com/azul_mouad/';
const kLinkWebSite = 'https://www.instagram.com/azul_mouad/';
const kLinkPrivacy = 'https://www.instagram.com/azul_mouad/';

// App or web site link will share
const kAppShareLink =
    'The best movies App in the world\n https://www.instagram.com/azul_mouad/';

// ABout dialog ( Settings Page )
const kAboutDialog =
    'Displays an About dialog, which describes the application.';
const kVersionApp = '1.0.0';

///
///
///
///
///
///
///
///
///
///
///
///
/// ******** Don't change codes bellow. ************
///
///
///
///
///
///
///
///
///
///
///
///
///

String getTranslationText(BuildContext context, String key) {
  return DemoLocalization.of(context).getTranslatedValue(key);
}

bool isLayoutRTL(context) {
  final TextDirection currentDirection = Directionality.of(context);
  return currentDirection == TextDirection.rtl;
}

DateTime twoDaysAgoDate(dateNow) =>
    DateTime(dateNow.year, dateNow.month, dateNow.day - 2, 0, 0);
DateTime yesterdayDate(dateNow) =>
    DateTime(dateNow.year, dateNow.month, dateNow.day - 1, 0, 0);

enum LayoutListOrGrid { list, grid }

const kStyleTitle01 = TextStyle(
  fontSize: 15.0,
  fontWeight: FontWeight.w500,
);
const kStyleTitle02 = TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600);

const kBoxShadow01 = BoxShadow(color: Colors.black26, blurRadius: 5.0);
const kBoxShadow02 = BoxShadow(color: Colors.black45, blurRadius: 5.0);

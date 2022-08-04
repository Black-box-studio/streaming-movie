import 'dart:ui';
import 'package:flutter/material.dart';
import '../constants.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      accentColor: kColorRed01,

      primarySwatch: Colors.red,
      primaryColor: isDarkTheme ? kColorBlack02 : Colors.white,
      primaryColorDark: isDarkTheme ? Colors.white : kColorBlack02,
      accentColorBrightness: isDarkTheme ? Brightness.dark : Brightness.light,
      backgroundColor: isDarkTheme ? kColorBlack02 : Color(0xffF1F5FB),
      indicatorColor: isDarkTheme ? Color(0xff0E1D36) : Color(0xffCBDCF8),
      buttonColor: isDarkTheme ? Color(0xffF1F5FB) : kColorBlack04,
      hintColor: isDarkTheme ? Color(0xff280C0B) : Color(0xffEECED3),
      // highlightColor: isDarkTheme ? Color(0xff372901) : Color(0xffFCE192),
      hoverColor: isDarkTheme ? Color(0xff3A3A3B) : Color(0xff4285F4),
      focusColor: isDarkTheme ? Color(0xff0B2512) : Color(0xffA8DAB5),
      disabledColor: Colors.grey,

      cardColor: isDarkTheme ? Color(0xFF151515) : Colors.white,
      canvasColor: isDarkTheme ? kColorBlack02 : Colors.grey[50],
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,

      //check box
      unselectedWidgetColor: kColorRed01,
      toggleableActiveColor: kColorRed01,

      buttonTheme: Theme.of(context).buttonTheme.copyWith(
            colorScheme: isDarkTheme ? ColorScheme.dark() : ColorScheme.light(),
          ),
      fontFamily: 'Changa',
      textTheme: TextTheme(
        bodyText1: TextStyle(
          color: isDarkTheme ? Colors.white : kColorBlack02,
        ),
        bodyText2: TextStyle(
          color: isDarkTheme ? Colors.white : kColorBlack02,
        ),
      ),

      // textTheme: GoogleFonts.poppinsTextTheme(
      //   Theme.of(context).textTheme,
      // ).copyWith(
      //   bodyText1: TextStyle(
      //     color: isDarkTheme ? Colors.white : kColorBlack02,
      //   ),
      //   bodyText2: TextStyle(
      //     color: isDarkTheme ? Colors.white : kColorBlack02,
      //   ),
      // ),
    );
  }
}

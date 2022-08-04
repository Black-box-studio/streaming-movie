import 'package:azul_movies/provider/main_functions.dart';
import 'package:azul_movies/screens/welcome_screen.dart';
import 'package:azul_movies/widgets/intro/inrto_mouad.dart';
import 'package:flutter/material.dart';
import 'package:azul_movies/models/notification.dart';

import 'intro_1.dart';
import 'intro_2.dart';
import 'intro_3.dart';
import 'intro_4.dart';

class IntroScreen extends StatelessWidget {
  final List<Widget> list = [
    IntroOne(),
    IntroTwo(),
    IntroThree(),
    IntroFour(),
  ];

  @override
  Widget build(BuildContext context) {
    return IntroMouad(
      introductionList: list,
      onTapSkipButton: () {
        //Save Intro
        MainFunctions.saveIntro();
        NotificationsHandler.subscribeToMovies(
            context: context, isSubscribe: true, showMessage: false);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => WelcomeScreen(),
          ), //MaterialPageRoute
        );
      },
    );
  }
}

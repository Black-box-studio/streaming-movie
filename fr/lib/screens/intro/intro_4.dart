import 'package:azul_movies/provider/main_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants.dart';

class IntroFour extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MainFunctions.saveIntro();
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              'assets/images/intro_1.svg',
              height: 360.0,
              width: 360.0,
              //fit: BoxFit.fitHeight,
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              getTranslationText(context, 'all_don'),
              textAlign: TextAlign.center,
              overflow: TextOverflow.clip,
              style: TextStyle(
                fontSize: 20.0,
                height: 1.2,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              getTranslationText(context, 'welcome_3'),
              style: TextStyle(fontSize: 15.0, height: 1.2),
            ),
          ],
        ),
      ),
    );
  }
}

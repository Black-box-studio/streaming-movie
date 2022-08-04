import 'package:azul_movies/models/func.dart';
import 'package:azul_movies/provider/dark_them_stats.dart';
import 'package:azul_movies/widgets/widgets_main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';

class IntroThree extends StatefulWidget {
  @override
  _IntroThreeState createState() => _IntroThreeState();
}

class _IntroThreeState extends State<IntroThree> {
  LayoutListOrGrid _listOrGrid = LayoutListOrGrid.list; //by default

  Future<void> checkLayoutIsListOrGrid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isList = prefs.getBool('Layout') ?? true;
    setState(() {
      if (isList) {
        _listOrGrid = LayoutListOrGrid.list;
      } else {
        _listOrGrid = LayoutListOrGrid.grid;
      }
    });
  }

  @override
  void initState() {
    checkLayoutIsListOrGrid();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              'assets/images/intro_3.svg',
              height: 360.0,
              width: 360.0,
              //fit: BoxFit.fitHeight,
            ),
            Text(
              getTranslationText(context, 'layout'),
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
              getTranslationText(context, 'layout_2'),
              style: TextStyle(fontSize: 15.0, height: 1.2),
            ),
            SizedBox(height: 20.0),
            Row(
              children: [
                Text(
                  getTranslationText(context, 'theme'),
                  style: TextStyle(fontSize: 15.0, height: 1.0),
                ),
                Spacer(),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(color: kColorRed01, width: 1.0),
                  ),
                  child: Row(
                    children: [
                      CardPickDarkLightMode(
                        label: 'Light',
                        isSelected: themeChange.darkTheme == true,
                        onPress: () {
                          setState(() {
                            themeChange.darkTheme = false;
                          });
                        },
                      ),
                      CardPickDarkLightMode(
                        label: 'Dark',
                        isSelected: themeChange.darkTheme == false,
                        onPress: () {
                          setState(() {
                            themeChange.darkTheme = true;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.0),
            Row(
              children: [
                Text(
                  getTranslationText(context, 'layout'),
                  style: TextStyle(fontSize: 15.0, height: 1.2),
                ),
                Spacer(),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(color: kColorRed01, width: 1.0),
                  ),
                  child: Row(
                    children: [
                      CardPickListOrGrid(
                        label: 'List',
                        isSelected: _listOrGrid == LayoutListOrGrid.list,
                        onPress: () async {
                          await Func.setLayoutIsListOrGrid(isList: true);
                          await checkLayoutIsListOrGrid();
                        },
                      ),
                      CardPickListOrGrid(
                        label: 'Grid',
                        isSelected: _listOrGrid == LayoutListOrGrid.grid,
                        onPress: () async {
                          await Func.setLayoutIsListOrGrid(isList: false);
                          await checkLayoutIsListOrGrid();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:azul_movies/localization/localization_constans.dart';

import 'package:azul_movies/widgets/widgets_into.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants.dart';
import '../../provider/language_device.dart';
import '../../main.dart';

class IntroTwo extends StatefulWidget {
  @override
  _IntroTwoState createState() => _IntroTwoState();
}

class _IntroTwoState extends State<IntroTwo> {
  var _flag = '🇺🇸'; //by default
  var _nameFlage = 'English'; //by default

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  void _changeLanguage(Language language) async {
    Locale _temp = await setLocales(
        languageCode: language.languageCode,
        flag: language.flag,
        name: language.name);
    MyApp.setLocale(context, _temp);
  }

  void getLanguageApp() async {
    SharedPreferences _perfs = await SharedPreferences.getInstance();
    //String codeLanguege = _perfs.getString(LANGUEGE_CODE) ?? 'en';
    String codeName = _perfs.getString(LANGUEGE_NAME) ?? 'English';
    String codeFlag = _perfs.getString(LANGUEGE_FLAG) ?? '🇺🇸';

    setState(() {
      _flag = codeFlag;
      _nameFlage = codeName;
    });
  }

  @override
  void initState() {
    getLanguageApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        key: _key,
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SvgPicture.asset(
                'assets/images/intro_2.svg',
                height: 360.0,
                width: 360.0,
                //fit: BoxFit.fitHeight,
              ),
            ),
            Text(
              getTranslationText(context, 'language'),
              textAlign: TextAlign.center,
              overflow: TextOverflow.clip,
              style: TextStyle(
                fontSize: 20.0,
                height: 1.5,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              getTranslationText(context, 'intru_two_sub'),
              style: TextStyle(fontSize: 15.0, height: 1.5),
            ),
            SizedBox(
              height: 5.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  getTranslationText(context, 'language'),
                  style: TextStyle(fontSize: 15.0, height: 1.2),
                ),
                DropdownButton<Language>(
                  icon: CardPickedLanguage(
                    name: _nameFlage,
                    flag: _flag,
                  ),
                  underline: SizedBox(),
                  items: LanguageDevice.listLanguage()
                      .map<DropdownMenuItem<Language>>(
                        (lang) => DropdownMenuItem<Language>(
                          value: lang,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                lang.flag,
                                style: TextStyle(fontSize: 15.0),
                              ),
                              Text(
                                lang.name,
                                style: TextStyle(fontSize: 15.0),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (Language language) {
                    _changeLanguage(language);
                    setState(() {
                      _nameFlage = language.name;
                      _flag = language.flag;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

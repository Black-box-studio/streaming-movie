import 'package:azul_movies/constants.dart';
import 'package:azul_movies/localization/localization_constans.dart';
import 'package:azul_movies/models/func.dart';
import 'package:azul_movies/provider/dark_them_stats.dart';
import 'package:azul_movies/widgets/widgets_into.dart';
import 'package:azul_movies/widgets/widgets_main.dart';
import 'package:azul_movies/widgets/widgets_settings.dart';
import 'package:azul_movies/widgets/widgets_toolbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../provider/language_device.dart';
import '../../main.dart';
import 'package:azul_movies/models/notification.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  LayoutListOrGrid _listOrGrid; //by default

  var _flag = '🇺🇸'; //by default
  var _nameFlage = 'English'; //by default
  bool _isSubscribe =
      true; //by default user is subscribe to get notifications about new movies

  void _changeLanguage(Language language) async {
    Locale _temp = await setLocales(
        languageCode: language.languageCode,
        name: language.name,
        flag: language.flag);
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

  Future<void> checkIfUserSubscribed() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var _subscribe = prefs.getBool('notification');

    //if user has never subscribe , subscribe for hem
    if (_subscribe == null) {
      print('User never Subscribe: $_subscribe');
      await prefs.setBool('notification', true);
    }

    setState(() {
      _isSubscribe = _subscribe ?? true;
    });
  }

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
    getLanguageApp();
    checkIfUserSubscribed();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return SafeArea(
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 70.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CardCheckUpdate(
                      isDark: themeChange.darkTheme,
                    ),
                    SizedBox(height: 15.0),
                    Text(
                      getTranslationText(context, 'appearance'),
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Theme.of(context).buttonColor,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    CardContainBack(
                      isDark: themeChange.darkTheme,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                getTranslationText(context, 'theme'),
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              Spacer(),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  border: Border.all(
                                      color: kColorRed01, width: 1.0),
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
                                      isSelected:
                                          themeChange.darkTheme == false,
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
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              Spacer(),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  border: Border.all(
                                      color: kColorRed01, width: 1.0),
                                ),
                                child: Row(
                                  children: [
                                    CardPickListOrGrid(
                                      label: 'List',
                                      isSelected:
                                          _listOrGrid == LayoutListOrGrid.list,
                                      onPress: () async {
                                        await Func.setLayoutIsListOrGrid(
                                            isList: true);
                                        await checkLayoutIsListOrGrid();
                                      },
                                    ),
                                    CardPickListOrGrid(
                                      label: 'Grid',
                                      isSelected:
                                          _listOrGrid == LayoutListOrGrid.grid,
                                      onPress: () async {
                                        await Func.setLayoutIsListOrGrid(
                                            isList: false);
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
                    SizedBox(height: 15.0),
                    Text(
                      getTranslationText(context, 'localization'),
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Theme.of(context).buttonColor,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    CardContainBack(
                      isDark: themeChange.darkTheme,
                      child: Row(
                        children: [
                          Text(
                            getTranslationText(context, 'language'),
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Spacer(),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
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
                    ),
                    SizedBox(height: 15.0),
                    Text(
                      getTranslationText(context, 'notification'),
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Theme.of(context).buttonColor,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    CardContainBack(
                      isDark: themeChange.darkTheme,
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              getTranslationText(context, 'notification'),
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Theme.of(context).buttonColor,
                              ),
                            ),
                          ),
                          Switch(
                            value: _isSubscribe,
                            onChanged: (value) async {
                              //check first if user subscribed or not
                              //save data in preference
                              await NotificationsHandler.subscribedUser(
                                sub: value,
                                context: context,
                              );
                              await checkIfUserSubscribed();
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15.0),
                    Text(
                      '${getTranslationText(context, 'about')} $kAppName',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Theme.of(context).buttonColor,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    CardContainBack(
                      isDark: themeChange.darkTheme,
                      child: Column(
                        children: [
                          CardTileAbout(
                            label: getTranslationText(context, 'share_app'),
                            onTap: () async {
                              await Func.shareApp();
                            },
                          ),
                          CardTileAbout(
                            label: getTranslationText(context, 'about'),
                            onTap: () {
                              showPageAbout(context);
                            },
                          ),
                          CardTileAbout(
                            label: getTranslationText(context, 'privacy'),
                            onTap: () async {
                              await launch(kLinkPrivacy);
                            },
                          ),
                          /* CardTileAbout(
                            label: getTranslationText(context, 'Whats_new'),
                            onTap: () {},
                          ),*/
                          CardTileAbout(
                            label: getTranslationText(context, 'website'),
                            onTap: () async {
                              await launch(kLinkWebSite);
                            },
                          ),
                          CardTileAbout(
                            label: getTranslationText(context, 'twitter'),
                            icon: FontAwesomeIcons.twitter,
                            onTap: () async {
                              await launch(kLinkTwitter);
                            },
                          ),
                          CardTileAbout(
                            label: getTranslationText(context, 'facebook'),
                            icon: FontAwesomeIcons.facebookF,
                            onTap: () async {
                              await launch(kLinkFacebook);
                            },
                          ),
                          CardTileAbout(
                            label: getTranslationText(context, 'insta'),
                            icon: FontAwesomeIcons.instagram,
                            onTap: () async {
                              await launch(kLinkInstagram);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          CardAppBarRed(
            title: getTranslationText(context, 'settings'),
          ),
        ],
      ),
    );
  }
}

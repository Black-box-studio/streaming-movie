import 'package:azul_movies/constants.dart';
import 'package:azul_movies/provider/language_device.dart';
import 'package:azul_movies/provider/dark_them_stats.dart';
import 'package:azul_movies/provider/style_dark_light.dart';
import 'package:azul_movies/screens/intro/intro_screen.dart';
import 'package:azul_movies/screens/search_screen.dart';
import 'package:azul_movies/screens/splash_screen.dart';
import 'package:azul_movies/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'localization/demo_localization.dart';
import 'localization/localization_constans.dart';
import 'models/notification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState state = context.findAncestorStateOfType();
    state.setLocale(locale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();
  Locale _locale;

  void setLocale(Locale temp) {
    setState(() {
      _locale = temp;
    });
  }

  @override
  void didChangeDependencies() {
    getLocales().then((locale) => {
          setState(() {
            this._locale = locale;
          }),
        });
    super.didChangeDependencies();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreference.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    NotificationsHandler.getMessages(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_locale == null) {
      return Center(child: CircularProgressIndicator());
    } else {
      return ChangeNotifierProvider(
        create: (_) => themeChangeProvider,
        child: Consumer<DarkThemeProvider>(
          builder: (context, value, child) {
            return MaterialApp(
              title: kAppName,
              debugShowCheckedModeBanner: false,
              localizationsDelegates: [
                DemoLocalization.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: LanguageDevice.kSupportedLocales,
              locale: _locale,
              localeResolutionCallback: (deviceLocale, supportedLocales) {
                for (var local in supportedLocales) {
                  if (local.languageCode == deviceLocale.languageCode &&
                      local.countryCode == deviceLocale.countryCode) {
                    return deviceLocale;
                  }
                }
                return supportedLocales.first;
              },
              theme: Styles.themeData(
                themeChangeProvider.darkTheme,
                context,
              ), //set the
              initialRoute: '/splash',
              routes: {
                '/splash': (_) => SplashScreen(),
                '/welcome_screen': (_) => WelcomeScreen(),
                '/intro': (_) => IntroScreen(),
                '/search': (_) => SearchScreen(),
              },
            );
          },
        ),
      );
    }
  }
}

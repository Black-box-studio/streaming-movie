import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:panel_back_end/constants.dart';
import 'package:panel_back_end/screens/login_screen.dart';
import 'package:panel_back_end/screens/welcome_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'initial/initial_web.dart';

//flutter run -d chrome --profile --verbose

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return InitialError(snapshot.error);
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
              title: kName,
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primaryColor: kColorPrimary,
                primaryColorDark: kColorPrimary,
                accentColor: kColorPrimary,
                textTheme: GoogleFonts.ralewayTextTheme(
                  Theme.of(context).textTheme,
                ),
              ),
              builder: (context, widget) => ResponsiveWrapper.builder(widget,
                  maxWidth: 1800,
                  minWidth: 480,
                  defaultScale: true,
                  breakpoints: [
                    ResponsiveBreakpoint.resize(480, name: MOBILE),
                    ResponsiveBreakpoint.resize(800, name: TABLET),
                    ResponsiveBreakpoint.resize(1800, name: DESKTOP),
                  ],
                  background: Container(color: Color(0xFFF5F5F5))),
              initialRoute: "/",
              routes: {
                '/': (_) => LogInScreen(),
                '/welcome': (_) => WelcomeScreen(),
              },
            );
          }

          return InitialProgress();
        });
  }
}

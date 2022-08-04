import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void checkIntroIsSaved() async {
    SharedPreferences _sharePrefer = await SharedPreferences.getInstance();
    bool codeIntro = _sharePrefer.getBool('INTRO') ?? false;

    if (codeIntro == true) {
      goScreen(screen: '/welcome_screen');
    } else {
      goScreen(screen: '/intro');
    }
  }

  void goScreen({String screen}) async {
    await Future.delayed(Duration(seconds: 3));
    Navigator.pushReplacementNamed(context, screen);
  }

  @override
  void initState() {
    checkIntroIsSaved();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedContainer(
          width: 200,
          height: 200,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: SvgPicture.asset(
            'assets/images/icon.svg',
          ),
        ),
      ),
    );
  }
}

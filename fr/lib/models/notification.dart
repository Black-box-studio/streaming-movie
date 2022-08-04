import 'package:azul_movies/screens/content/content_movie_screen.dart';
import 'package:azul_movies/widgets/card_visible.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:azul_movies/widgets/dialog_notification.dart';

import '../constants.dart';

final _firebaseMessaging = FirebaseMessaging();

class NotificationsHandler {
  static Future<void> getMessages({@required context}) async {
    _firebaseMessaging.configure(
      onMessage: (message) async {
        //onMessage fires when the app is open and running in the foreground.
        print('onMessage');

        var notification = message['notification'];
        var data = message['data'];

        showDialog(
          context: context,
          builder: (context) => DialogNotification(
            title: notification['title'].toString(),
            body: notification['body'].toString(),
            image: data['image'].toString(),
            idMovie: data['id_movie'].toString(),
          ),
        );
      },
      onResume: (message) async {
        //=> onResume fires if the app is closed, but still running in the background.
        print('onResume');

        var idMovie = message['data']['id_movie'].toString() ?? '';
        _launchScreen(context: context, idMovie: idMovie);
      },
      onLaunch: (message) async {
        //onLaunch fires if the app is fully terminated.
        print('onLaunch');
        var idMovie = message['data']['id_movie'].toString() ?? '';
        _launchScreen(context: context, idMovie: idMovie);
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }

  static Future<String> getDeviceToken() async {
    String token = await _firebaseMessaging.getToken();
    print(token);
    //idea : save token in device, check if device has token then get's notification if not don't get notification.
    return token;
  }

  static subscribeToMovies(
      {bool isSubscribe, @required context, bool showMessage = true}) async {
    try {
      isSubscribe
          ? await _firebaseMessaging.subscribeToTopic('Movies')
          : await _firebaseMessaging.unsubscribeFromTopic('Movies');

      if (!showMessage) {
        return false;
      }
      showTopSnackBare(
          context: context,
          isSuccess: isSubscribe,
          isInfo: !isSubscribe,
          message: getTranslationText(
              context, isSubscribe ? 'isSubscribe' : 'isNotSubscribe'));
    } catch (e) {
      print(e);
      showTopSnackBare(
          context: context,
          isError: true,
          message: getTranslationText(context, '$e'));
    }

    print('User subscribe: $isSubscribe');
  }

  static _launchScreen({context, String idMovie}) {
    try {
      if (idMovie.isNotEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ContentMovieScreen(idMovie: idMovie),
          ),
        );
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  static Future<void> subscribedUser({sub, @required context}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notification', sub ?? true);
    await NotificationsHandler.subscribeToMovies(
        isSubscribe: sub, context: context);
  }
}

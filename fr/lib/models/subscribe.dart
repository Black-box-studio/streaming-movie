import 'package:azul_movies/widgets/card_visible.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'notification.dart';
import 'package:platform_device_id/platform_device_id.dart';

final _firebase = FirebaseFirestore.instance;

class Subscribe {
  static Future<bool> subscribeToMovie({
    String idMovie,
    @required context,
  }) async {
    try {
      String deviceId = await PlatformDeviceId.getDeviceId;

      final _movies =
          await _firebase.collection('Subscribers').doc(deviceId).get();
      //check first if user id device is already in database
      // if true => update data
      if (_movies.exists) {
        List<dynamic> mListMovies =
            await getListSubscribeMovies(idDevice: deviceId);
        mListMovies.add(idMovie);

        print('update data');
        await _firebase.collection('Subscribers').doc(deviceId).update({
          'token': await NotificationsHandler.getDeviceToken(),
          'movies': mListMovies,
        });
      }
      // if false => set data
      else {
        print('create data');
        await _firebase.collection('Subscribers').doc(deviceId).set({
          'token': await NotificationsHandler.getDeviceToken(),
          'movies': [idMovie],
        });
      }

      return true;
    } catch (e) {
      print(e);
      showTopSnackBare(context: context, isError: true, message: '$e');
      return false;
    }
  }

  static Future<bool> unSubscribeToMovie({
    String idMovie,
    @required context,
  }) async {
    try {
      String deviceId = await PlatformDeviceId.getDeviceId;

      List<dynamic> _movies = await getListSubscribeMovies(idDevice: deviceId);

      for (var i = 0; i < _movies.length; i++) {
        if (_movies[i] == idMovie) {
          _movies.removeAt(i);
        }
      }

      //save new data
      await _firebase.collection('Subscribers').doc(deviceId).update({
        'movies': _movies,
      });

      return true;
    } catch (e) {
      print(e);
      showTopSnackBare(context: context, isError: true, message: '$e');
      return false;
    }
  }

  static Future<bool> checkMovieSubscribe({String idMovie}) async {
    try {
      String deviceId = await PlatformDeviceId.getDeviceId;

      final _movies =
          await _firebase.collection('Subscribers').doc(deviceId).get();

      bool isThere = false;

      //check first if user idDevice already in database
      if (_movies.exists) {
        List<dynamic> listIdMovies = _movies.data()['movies'] ?? [];

        for (var i = 0; i < listIdMovies.length; i++) {
          if (listIdMovies[i] == idMovie) {
            isThere = true;
            print('This id already subscribed : $isThere');
          }
        }
      } else {
        isThere = false;
      }

      return isThere;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<List<dynamic>> getListSubscribeMovies({idDevice}) async {
    final _list = await _firebase.collection('Subscribers').doc(idDevice).get();
    return _list.data()['movies'] ?? [];
  }
}

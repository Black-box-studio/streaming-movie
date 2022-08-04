import 'package:azul_movies/constants.dart';
import 'package:azul_movies/models/func.dart';
import 'package:azul_movies/widgets/card_visible.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:url_launcher/url_launcher.dart';

final _firestore = FirebaseFirestore.instance;

class Database {
  static getAllPosts() {
    return _firestore
        .collection('Posts')
        .orderBy('timeMap', descending: true)
        .limit(kMaxPostCarousel)
        .snapshots();
  }

  static getPostsDate({@required timeMap, @required bool oldPosts}) {
    //if oldPosts == true : show old selectedDate posts

    if (kDemoApp) {
      return _firestore.collection('Posts').snapshots();
    } else
      return oldPosts
          ? _firestore
              .collection('Posts')
              .where('timeMap', isLessThanOrEqualTo: timeMap)
              .limit(kMaxPostMovies)
              .snapshots()
          : _firestore
              .collection('Posts')
              .where('timeMap', isEqualTo: timeMap)
              .snapshots();
  }

  static getTypePosts({@required type, bool isLimited = true}) {
    if (isLimited) {
      return _firestore
          .collection('Posts')
          .where('type', isEqualTo: type)
          .limit(kMaxPostsMoviesBottomHome)
          .snapshots();
    }

    return _firestore
        .collection('Posts')
        .where('type', isEqualTo: type)
        .snapshots();
  }

  static Future<int> getSizeEpisodes({@required document}) async {
    final size = await _firestore
        .collection('Posts')
        .doc(document)
        .collection('Episodes')
        .get();

    return size.docs.length;
  }

  static Future<dynamic> getPost({@required document}) async {
    final mPost = await _firestore.collection('Posts').doc(document).get();
    return mPost.data();
  }

  static getSearchNamePost({@required name}) {
    return _firestore
        .collection('Posts')
        .where('name', isGreaterThanOrEqualTo: name)
        .snapshots();
  }

  static Future<dynamic> getArrayMovie({@required document}) async {
    final mPost = await _firestore.collection('Posts').doc(document).get();
    return mPost;
  }

  static getEpisodes({@required idDocument}) {
    return _firestore
        .collection('Posts')
        .doc(idDocument)
        .collection('Episodes')
        .orderBy('timeMap', descending: true)
        .snapshots();
  }

  static getServers(
      {@required idDocument, @required idEpisode, @required bool isMovie}) {
    if (isMovie) {
      return _firestore
          .collection('Posts')
          .doc(idDocument)
          .collection('Servers')
          .orderBy('timeMap', descending: true)
          .snapshots();
    } else {
      return _firestore
          .collection('Posts')
          .doc(idDocument)
          .collection('Episodes')
          .doc(idEpisode)
          .collection('Servers')
          .orderBy('timeMap', descending: true)
          .snapshots();
    }
  }

  static getCategories() {
    return _firestore.collection('Categories').snapshots();
  }

  static getTheTop() async {
    var top = await _firestore
        .collection('TheTop')
        .orderBy('timeMap', descending: true)
        .get();

    return top.docs;
  }

  static getTheTopPosts({@required idDocument}) {
    return _firestore
        .collection('TheTop')
        .doc(idDocument)
        .collection('Movies')
        .snapshots();
  }

  static getCatyPosts({@required caty}) {
    //check categories
    return _firestore
        .collection('Posts')
        .where('categories', arrayContains: caty)
        .snapshots();
  }

  static Future<bool> getFuncIsEditore() async {
    try {
      final func = await _firestore
          .collection('Functions')
          .doc('Editor_Recommended')
          .get();

      print('The Editore is : ${func.data()['isShooses']}');
      return func.data()['isShooses'] == 'true' ?? false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static getEditorPosts() {
    //EditorShooses
    return _firestore.collection('EditorShooses').snapshots();
  }

  static getRecommendedPosts({@required List<String> categories}) {
    // Recommended
    return categories.isNotEmpty
        ? _firestore
            .collection('Posts')
            .where('categories', arrayContainsAny: categories)
            .limit(kMaxPostRecommends)
            .snapshots()
        : null;
  }

  static getTimePosts({time, bool isEqual = false}) {
    //TODO if demo shows all posts
    if (kDemoApp) {
      return _firestore.collection('Posts').snapshots();
    }
    if (isEqual) {
      return _firestore
          .collection('Posts')
          .where('timeMap', isEqualTo: time)
          .snapshots();
    }
    return time == null
        ? _firestore
            .collection('Posts')
            .orderBy('timeMap', descending: true)
            .snapshots()
        : _firestore
            .collection('Posts')
            .where('timeMap', isLessThanOrEqualTo: time)
            .snapshots();
  }

  static Future<dynamic> checkUpdateApp(context, {isMain = false}) async {
    try {
      final _update =
          await _firestore.collection('Functions').doc('update').get();

      var _newVersion = _update.data()['version'].toString();
      var _versionApp = await Func.getPackageVersion();
      var title = _update.data()['title'] ?? 'new version available';
      var message = _update.data()['message'] ??
          'please click update to get the latest version.';
      var link = _update.data()['link'];

      if (_newVersion != _versionApp) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: Text(
              '$title',
              style: TextStyle(fontSize: 20.0),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  'assets/images/update_app.svg',
                  height: 220.0,
                  // fit: BoxFit.cover,
                ),
                Text(
                  '$message',
                  style: TextStyle(fontSize: 15.0),
                ),
              ],
            ),
            actions: [
              FlatButton(
                onPressed: () => Navigator.pop(context),
                textColor: Colors.grey,
                child: Text('later'),
              ),
              FlatButton(
                onPressed: () async {
                  if (await canLaunch(link)) {
                    Navigator.pop(context);
                    launch(link);
                  } else {
                    Navigator.pop(context);
                    showTopSnackBare(
                        context: context,
                        isError: true,
                        message:
                            getTranslationText(context, 'link_update_error'));
                  }
                },
                textColor: Colors.white,
                color: kColorRed01,
                child: Text('update'),
              ),
            ],
          ),
        );
      } else {
        //if function from Main don't show this message, with that you won't get the message every time you open the app
        if (isMain) {
          return false;
        }
        showTopSnackBare(
            context: context,
            isSuccess: true,
            message: getTranslationText(context, 'latest_version'));
      }
    } catch (e) {
      print('Update App Error: $e');
    }
  }

  ///Trailer video youtube info
  // static Future<String> getTrailerInfo({ytVideoID}) async {
  //   try {
  //     await YoutubeVideoValidator.validateID(ytVideoID, loadData: true);
  //     return YoutubeVideoValidator.video.thubmnail.toString();
  //   } catch (e) {
  //     print(e);
  //     return '';
  //   }
  // }
}

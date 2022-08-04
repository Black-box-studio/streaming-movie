import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../constants.dart';

final _fireStore = FirebaseFirestore.instance;

class Database {
  static setLocalHost() {
    //  _fireStore.settings = Settings(host: "localhost:8080", sslEnabled: false);
  }

  static Future<int> getSizedMovies({@required key}) async {
    // setLocalHost();
    final size = await _fireStore
        .collection('Posts')
        .where('type', isEqualTo: key)
        .get();
    return size.docs.length ?? 0;
  }

  static Future<int> getSizedCategoriesAndStudio({@required key}) async {
    final size = await _fireStore.collection('$key').get();
    return size.docs.length ?? 0;
  }

  static Future<bool> checkEditorIsShoos() async {
    final size = await _fireStore
        .collection('Functions')
        .doc('Editor_Recommended')
        .get();

    return size.data()['isShooses'] == 'true' ?? null;
  }

  static Future<void> setEditorIsShoos({value}) async {
    try {
      await _fireStore.collection('Functions').doc('Editor_Recommended').set({
        'isShooses': value,
      });
    } catch (e) {
      print(e);
    }
  }

  static getMoviesType({type, timeMap, search}) {
    if (search == '' || search == null || timeMap == null) {
      print('1: $type ');
      return _fireStore
          .collection('Posts')
          .where('type', isEqualTo: type)
          .snapshots();
    }
    if (search == '' || search == null || timeMap != null) {
      print('3: $type   $timeMap');
      return _fireStore
          .collection('Posts')
          .where('type', isEqualTo: type)
          .where('timeMap', isEqualTo: timeMap)
          .snapshots();
    } else {
      print('3: $type  / $search');
      return _fireStore
          .collection('Posts')
          .where('type', isEqualTo: type)
          .where('name', isGreaterThanOrEqualTo: capitalize(search))
          .snapshots();
    }
  }

  static getListCategories() async {
    var data = await _fireStore.collection('Categories').get();
    return data.docs;
  }

  static getListStudios() async {
    var data = await _fireStore.collection('Studios').get();
    return data.docs;
  }

  static getCategoriesAndStudio({type}) {
    return _fireStore.collection('$type').snapshots();
  }

  static getRecommenededAndEditorShooses({type}) {
    return _fireStore.collection('$type').snapshots();
  }

  static getPosts({type, search}) {
    /// search == null // type != null
    if (search == '' || search == null || type != null) {
      return _fireStore
          .collection('Posts')
          .where('type', isEqualTo: type)
          .snapshots();
    }

    /// type != null // search != null get search from type
    else if (type != null || search != '' || search != null) {
      return _fireStore
          .collection('Posts')
          .where('type', isEqualTo: type)
          .where('name', isGreaterThanOrEqualTo: capitalize(search))
          .snapshots();
    }

    /// type == null  get All Posts
    else if (type == null) {
      return _fireStore
          .collection('Posts')
          .orderBy('timeMap', descending: true)
          .snapshots();
    }
  }

  static getListTheTop() {
    return _fireStore.collection('TheTop').orderBy('timeMap').snapshots();
  }

  static Future<int> getSizeListTopPick({document}) async {
    final mData = await _fireStore
        .collection('TheTop')
        .doc(document)
        .collection('Movies')
        .get();

    return mData.docs.length ?? 0;
  }

  static getListPickTheTop({document}) {
    return _fireStore
        .collection('TheTop')
        .doc(document)
        .collection('Movies')
        .snapshots();
  }

  static Future<dynamic> getMovieData({idMovie}) async {
    final movie = await _fireStore.collection('Posts').doc(idMovie).get();

    return movie.data();
  }

  static getServers({idMovie, bool isSerie, idEpisod}) {
    if (isSerie) {
      return _fireStore
          .collection('Posts')
          .doc(idMovie)
          .collection('Episodes')
          .doc(idEpisod)
          .collection('Servers')
          .snapshots();
    } else {
      return _fireStore
          .collection('Posts')
          .doc(idMovie)
          .collection('Servers')
          .snapshots();
    }
  }

  static getEpisodes({idMovie, String search}) {
    if (search.isNotEmpty) {
      print('search active');
      return _fireStore
          .collection('Posts')
          .doc(idMovie)
          .collection('Episodes')
          .where('title', isGreaterThanOrEqualTo: capitalize(search))
          .snapshots();
    } else {
      print('search disactive');
      return _fireStore
          .collection('Posts')
          .doc(idMovie)
          .collection('Episodes')
          .snapshots();
    }
  }

  static getUpdateInfo() async {
    final _update =
        await _fireStore.collection('Functions').doc('update').get();

    return _update.data();
  }
}

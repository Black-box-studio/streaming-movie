import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:panel_back_end/models/ui/ui.dart';
import '../constants.dart';

final _fireStore = FirebaseFirestore.instance;

class Update {
  static Future<bool> updateMovie({
    @required idMovie,
    String name,
    String summary,
    String date,
    String firstAired,
    String status,
    String minutes,
    String format,
    String source,
    String linkMovie,
    String imageCover,
    List<Categories> listCategories,
    List<Studios> listStudios,
    List<Character> listCharacters,
    List<String> listTrailers,
  }) async {
    try {
      /// Change list to String
      List<String> mCaty = [];
      for (var caty in listCategories) {
        if (caty.selected) {
          mCaty.add(caty.title);
        }
      }

      /// Change list to String
      List<String> mStudio = [];
      for (var stu in listStudios) {
        if (stu.selected) {
          mStudio.add(stu.title);
        }
      }

      /// Change List to list<Map>
      List<Map> mCharacter = [];
      for (var char in listCharacters) {
        mCharacter.add({'image': char.image, 'name': char.name});
      }

      /// Change List to list<Map>
      List<Map> mTrailers = [];
      for (var i = 0; i < listTrailers.length; i++) {
        mTrailers.add({'link': '${listTrailers[i]}'});
      }
      Map<String, dynamic> mMapData = {
        'name': capitalize(name),
        'summary': capitalize(summary),
        'date': date,
        'firstAired': firstAired,
        'status': capitalize(status),
        'time': minutes,
        'season': '',
        'format': capitalize(format),
        'source': capitalize(source),
        'image': imageCover,
        'timeMap': getDateFormat(DateTime.now()),
        'categories': mCaty,
        'characters': mCharacter,
        'studio': mStudio,
        'trailers': mTrailers,
        'type': 'movie',
      };

      await _fireStore.collection('Posts').doc(idMovie).update(mMapData);

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> updateSeire({
    @required idMovie,
    String name,
    String summary,
    String date,
    String firstAired,
    String status,
    String minutes,
    String format,
    String source,
    String linkMovie,
    String imageCover,
    String season,
    List<Categories> listCategories,
    List<Studios> listStudios,
    List<Character> listCharacters,
    List<String> listTrailers,
  }) async {
    try {
      /// Change list to String
      List<String> mCaty = [];
      for (var caty in listCategories) {
        if (caty.selected) {
          mCaty.add(caty.title);
        }
      }

      /// Change list to String
      List<String> mStudio = [];
      for (var stu in listStudios) {
        if (stu.selected) {
          mStudio.add(stu.title);
        }
      }

      /// Change List to list<Map>
      List<Map> mCharacter = [];
      for (var char in listCharacters) {
        mCharacter.add({'image': char.image, 'name': char.name});
      }

      /// Change List to list<Map>
      List<Map> mTrailers = [];
      for (var i = 0; i < listTrailers.length; i++) {
        mTrailers.add({'link': '${listTrailers[i]}'});
      }
      Map<String, dynamic> mMapData = {
        'name': capitalize(name),
        'summary': capitalize(summary),
        'date': date,
        'firstAired': firstAired,
        'status': capitalize(status),
        'time': minutes,
        'season': capitalize(season),
        'format': capitalize(format),
        'source': capitalize(source),
        'image': imageCover,
        'timeMap': getDateFormat(DateTime.now()),
        'categories': mCaty,
        'characters': mCharacter,
        'studio': mStudio,
        'trailers': mTrailers,
      };

      await _fireStore.collection('Posts').doc(idMovie).update(mMapData);

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}

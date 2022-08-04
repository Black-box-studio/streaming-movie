import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:flutter/material.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:image_picker_web_redux/image_picker_web_redux.dart';
import 'package:panel_back_end/models/ui/ui.dart';
import '../constants.dart';

final _fireStore = FirebaseFirestore.instance;

class Upload {
  static Future<String> selectImage() async {
    html.File imageFile =
        await ImagePickerWeb.getImage(outputType: ImageType.file);

    if (imageFile != null) {
      return await uploadImageFile(imageFile, imageName: imageFile.name);
    } else {
      return null;
    }
  }

  static Future<dynamic> uploadImageFile(html.File image,
      {String imageName}) async {
    try {
      fb.StorageReference storageRef =
          fb.storage().ref('Characters/$imageName');
      fb.UploadTaskSnapshot uploadTaskSnapshot =
          await storageRef.put(image).future;

      Uri imageUri = await uploadTaskSnapshot.ref.getDownloadURL();
      print(imageUri);

      return imageUri.toString();
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<bool> uploadMovie({
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
    List<TextEditingController> listServers,
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

      /* await _fireStore.collection('Posts').add({
        'data': jsonEncode(mMapData),
      });*/

      await _fireStore.collection('Posts').add(mMapData);

      ///Add Servers to new Collection
      /* for (var server in listServers) {
        mData.collection('Servers').add({
          'server': server.text,
          'title' :''
        });
      }*/

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> uploadSerie({
    @required type,
    String name,
    String summary,
    String date,
    String firstAired,
    String status,
    String minutes,
    String season,
    String format,
    String source,
    String linkMovie,
    String imageCover,
    List<Categories> listCategories,
    List<Studios> listStudios,
    List<Character> listCharacters,
    List<TextEditingController> listEpisodesName,
    List<TextEditingController> listServerName,
    List<TextEditingController> listServerLink,
    List<String> listTrailers,
  }) async {
    try {
      /// Change list to String
      List<String> mCaty = [];
      for (var caty in listCategories) {
        if (caty.selected) {
          mCaty.add(capitalize(caty.title));
        }
      }

      /// Change list to String
      List<String> mStudio = [];
      for (var stu in listStudios) {
        if (stu.selected) {
          mStudio.add(capitalize(stu.title));
        }
      }

      /// Change List to list<Map>
      List<Map> mCharacter = [];
      for (var char in listCharacters) {
        mCharacter.add({'image': char.image, 'name': capitalize(char.name)});
      }

      /// Change List to list<Map>
      List<Map> mTrailers = [];
      for (var i = 0; i < listTrailers.length; i++) {
        mTrailers.add({'link': '${listTrailers[i]}'});
      }

      final mData = await _fireStore.collection('Posts').add({
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
        'type': '$type',
      });

      ///Add Servers to new Collection
      var mEpisode = mData.collection('Episodes');
      for (var e = 0; e < listEpisodesName.length; e++) {
        mEpisode.doc('${listEpisodesName[e].text}').set({
          'title': listEpisodesName[e].text,
          'timeMap': getDateFormat(DateTime.now()),
        });
      }

      for (var e = 0; e < listEpisodesName.length; e++) {
        mEpisode.doc('${listEpisodesName[e].text}').collection('Servers').add({
          'name': listServerName[e].text,
          'server': listServerLink[e].text,
          'timeMap': getDateFormat(DateTime.now()),
        });
      }

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> uploadCategoriesAndStudio(
      {title, image, @required type}) async {
    try {
      await _fireStore.collection('$type').add({
        'title': capitalize(title.toString()),
        'image': image.toString(),
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> uploadPickedTypeMovie(
      {name, image, idMovie, summary, isEditore}) async {
    try {
      await _fireStore
          .collection(isEditore ? 'EditorShooses' : 'Recommended')
          .add({
        'name': capitalize(name),
        'image': image,
        'summary': capitalize(summary),
        'id_movie': idMovie,
        'timeMap': getDateFormat(DateTime.now()),
      });

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> uploadListTheTop({title}) async {
    try {
      final _upload = await _fireStore.collection('TheTop').add({
        'title': capitalize(title),
        'key': '',
        'timeMap': getDateFormat(DateTime.now()),
      });

      _upload.update({
        'key': _upload.id,
      });

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> uploadMovieToTheTop(
      {document, name, summary, image, idMovie}) async {
    try {
      await _fireStore
          .collection('TheTop')
          .doc(document)
          .collection('Movies')
          .add({
        'name': name,
        'summary': summary,
        'image': image,
        'id_movie': idMovie,
        'timeMap': getDateFormat(DateTime.now()),
      });

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> uploadServer(
      {idMovie, name, link, @required isSerie, idEpisod}) async {
    try {
      if (isSerie) {
        await _fireStore
            .collection('Posts')
            .doc(idMovie)
            .collection('Episodes')
            .doc(idEpisod)
            .collection('Servers')
            .add({
          'name': capitalize(name),
          'server': link,
          'timeMap': getDateFormat(DateTime.now()),
        });
        return true;
      } else {
        await _fireStore
            .collection('Posts')
            .doc(idMovie)
            .collection('Servers')
            .add({
          'name': capitalize(name),
          'server': link,
          'timeMap': getDateFormat(DateTime.now()),
        });
        return true;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> uploadEpisode({idMovie, title}) async {
    try {
      await _fireStore
          .collection('Posts')
          .doc(idMovie)
          .collection('Episodes')
          .add({
        'title': capitalize(title),
        'timeMap': getDateFormat(DateTime.now()),
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> uploadUpdate({Map<String, dynamic> mMap}) async {
    try {
      await _fireStore.collection('Functions').doc('update').set(mMap);
      return true;
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }
}

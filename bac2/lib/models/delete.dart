import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:panel_back_end/widgets/cards_snackBar.dart';

final _fireStore = FirebaseFirestore.instance;

class Deletes {
  static removeCategory({document, @required context}) async {
    await _fireStore.collection('Categories').doc(document).delete();
    showSnackBar(context, 'Item removed successfully.');
  }

  static removePickPost({isEditore, document, @required context}) async {
    await _fireStore
        .collection(isEditore ? 'EditorShooses' : 'Recommended')
        .doc(document)
        .delete();
    showSnackBar(context, 'Item removed successfully.');
  }

  static removeMovie({document, @required context}) async {
    await _fireStore.collection('Posts').doc(document).delete();
    showSnackBar(context, 'Item removed successfully.');
  }

  static removeListTheTop({document, @required context}) async {
    await _fireStore.collection('TheTop').doc(document).delete();
    showSnackBar(context, 'Item removed successfully.');
  }

  static removeTheTop({document, pickId, @required context}) async {
    await _fireStore
        .collection('TheTop')
        .doc(document)
        .collection('Movies')
        .doc(pickId)
        .delete();
    showSnackBar(context, 'Item removed successfully.');
  }

  static removeEpisode({idMovie, idEpisod, @required context}) async {
    await _fireStore
        .collection('Posts')
        .doc(idMovie)
        .collection('Episodes')
        .doc(idEpisod)
        .delete();

    // showSnackBar(context, 'Item removed successfully.');
  }

  static removeServer(
      {idMovie,
      idSever,
      isEpisode,
      @required context,
      @required isSerie}) async {
    if (isSerie) {
      await _fireStore
          .collection('Posts')
          .doc(idMovie)
          .collection('Episodes')
          .doc(isEpisode)
          .collection('Servers')
          .doc(idSever)
          .delete();
    } else {
      await _fireStore
          .collection('Posts')
          .doc(idMovie)
          .collection('Servers')
          .doc(idSever)
          .delete();
    }
    // showSnackBar(context, 'Item removed successfully.');
  }
}

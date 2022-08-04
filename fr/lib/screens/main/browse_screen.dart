import 'package:azul_movies/constants.dart';
import 'package:azul_movies/models/database.dart';
import 'package:azul_movies/models/func.dart';
import 'package:azul_movies/widgets/widgets_browse.dart';

import 'package:azul_movies/widgets/widgets_toolbar.dart';

import 'package:flutter/material.dart';

class BrowseScreen extends StatefulWidget {
  @override
  _BrowseScreenState createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  List<Widget> mListBrowser = [];

  Future<void> getTheTop() async {
    final mSnapshot = await Database.getTheTop();

    try {
      for (var top in mSnapshot) {
        setState(() {
          mListBrowser.add(
            CardCatyListMovies(
              labelCaty: top['title'],
              idTheTop: top.id,
            ),
          );
        });
      }

      //Put Categories between list
      setState(() {
        mListBrowser.insert(2, Func.getAllCategories());
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    getTheTop();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 60.0),
                child: Column(
                  children: mListBrowser,
                ),
              ),
            ),
            CardAppBarRed(
              title: getTranslationText(context, 'browse_movies'),
            ),
          ],
        ),
      ),
    );
  }
}

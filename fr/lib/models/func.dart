import 'package:azul_movies/screens/all_categories/all_categories_screen.dart';
import 'package:azul_movies/screens/all_categories/all_movies_screen.dart';
import 'package:azul_movies/sqlite/movies.dart';
import 'package:azul_movies/sqlite/sqlite.dart';
import 'package:azul_movies/widgets/widgets_browse.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import 'database.dart';

class Func {
  static StreamBuilder<QuerySnapshot> getAllCategories() {
    return StreamBuilder<QuerySnapshot>(
        stream: Database.getCategories(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return LinearProgressIndicator();
          }

          final mCategories = snapshot.data.docs;
          List<CardRawCaty> mListCardRawCaty = [];

          for (var caty in mCategories) {
            mListCardRawCaty.add(
              CardRawCaty(
                image: caty.data()['image'],
                title: caty.data()['title'],
                onTap: () {
                  //SHow All Categories
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AllMoviesScreen(
                        category: caty.data()['title'],
                        idMovie: caty.id,
                        isCategory: true,
                      ),
                    ),
                  );
                },
              ),
            );
          }

          mListCardRawCaty.add(
            CardRawCaty(
              image: kAllCategoriesLinkImage,
              title: 'All',
              onTap: () {
                //SHow All Categories
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AllCategories(),
                  ),
                );
              },
            ),
          );

          return Container(
            width: double.infinity,
            height: 55.0,
            margin: EdgeInsets.symmetric(vertical: 15.0),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: mListCardRawCaty,
            ),
          );
        });
  }

  static saveMovieToFavorite(Movies movies) async {
    await DBProvider.db.newMovie(
      movies,
    );
  }

  static deleteMovieFromFavorite({id}) async {
    await DBProvider.db.deleteMovie(id);
  }

  static Future<bool> checkMovieIsInFavorites({id}) async {
    try {
      final _movie = await DBProvider.db.getMovie(id);
      print(_movie.name);
      return true;
    } catch (e) {
      print('Error : $e');
      return false;
    }
  }

  static Future<String> getPackageVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    // String buildNumber = packageInfo.buildNumber;

    print(version);
    return version.toString() ?? '';
  }

  static Future<void> setLayoutIsListOrGrid({isList}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('Layout', isList);
    print('Layout is $isList');
  }

  static shareApp() async {
    await Share.share('$kAppShareLink', subject: 'text');
  }
}

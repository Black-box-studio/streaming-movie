import 'package:azul_movies/constants.dart';
import 'package:azul_movies/models/database.dart';
import 'package:azul_movies/models/func.dart';
import 'package:azul_movies/widgets/widgets_search.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'content/content_movie_screen.dart';
import 'main/favorite_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var _keySearch = '';

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  @override
  Widget build(BuildContext context) {
    ///Size Layout
    final mSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 60.0),
        child: Column(
          children: [
            InputSearch(
              mSize: mSize,
              hint: getTranslationText(context, 'search_by_name'),
              value: (value) {
                print('${capitalize(value)}');
                setState(() {
                  _keySearch = capitalize(value);
                });
              },
            ),
            SizedBox(height: 10.0),
            // Categories
            Func.getAllCategories(),
            Flexible(
              child: StreamBuilder<QuerySnapshot>(
                  stream: Database.getSearchNamePost(name: _keySearch),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return LinearProgressIndicator();
                    }

                    final mSearch = snapshot.data.docs;
                    if (mSearch.isEmpty || _keySearch == '') {
                      return Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child:
                              SvgPicture.asset('assets/images/search_img.svg'),
                        ),
                      );
                    }
                    List<CardMoviesDisplay> mListCardMoviesDisplay = [];

                    for (var search in mSearch) {
                      mListCardMoviesDisplay.add(
                        CardMoviesDisplay(
                          isDirectionLTR: !isLayoutRTL(context),
                          image: search.data()['image'],
                          title: search.data()['name'],
                          body: search.data()['summary'],
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ContentMovieScreen(
                                  idMovie: search.id,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }

                    return ListView(
                      physics: BouncingScrollPhysics(),
                      padding:
                          EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                      children: mListCardMoviesDisplay,
                    );
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(vertical: 60.0),
        child: FloatingActionButton(
          onPressed: () => Navigator.pop(context),
          child: Icon(
            isLayoutRTL(context)
                ? FontAwesomeIcons.chevronRight
                : FontAwesomeIcons.chevronLeft,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

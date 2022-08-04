import 'package:azul_movies/models/database.dart';
import 'package:azul_movies/screens/content/content_movie_screen.dart';
import 'package:azul_movies/widgets/widgets_home.dart';
import 'package:azul_movies/widgets/widgets_toolbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';
import '../main/favorite_screen.dart';

class AllMoviesScreen extends StatefulWidget {
  final category;
  final idMovie;
  final bool isCategory;
  final typeMovies;

  AllMoviesScreen(
      {this.category, this.isCategory = true, this.idMovie, this.typeMovies});

  @override
  _AllMoviesScreenState createState() => _AllMoviesScreenState();
}

class _AllMoviesScreenState extends State<AllMoviesScreen> {
  bool _isList = true;
  var _stream;

  Future<void> checkLayoutIsListOrGrid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isList = prefs.getBool('Layout') ?? true;
    setState(() {
      _isList = isList;
    });
  }

  @override
  void initState() {
    checkLayoutIsListOrGrid();
    if (widget.typeMovies != null) {
      _stream =
          Database.getTypePosts(type: widget.typeMovies, isLimited: false);
    } else {
      _stream = widget.isCategory
          ? Database.getCatyPosts(caty: widget.category)
          : Database.getTheTopPosts(idDocument: widget.idMovie);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          StreamBuilder<QuerySnapshot>(
              stream: _stream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return LinearProgressIndicator();
                }

                final mMovies = snapshot.data.docs;

                if (mMovies.isEmpty) {
                  return Center(
                    child: Text('Empty...'),
                  );
                }
                List<Widget> mListCardMoviesDisplay = [];

                for (var movie in mMovies) {
                  if (_isList) {
                    mListCardMoviesDisplay.add(
                      CardMoviesDisplay(
                        isDirectionLTR: !isLayoutRTL(context),
                        image: movie.data()['image'],
                        title: movie.data()['name'],
                        body: movie.data()['summary'] ?? '...',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ContentMovieScreen(
                                idMovie: movie.data()['id_movie'],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    mListCardMoviesDisplay.add(
                      CardListMovie(
                        image: movie.data()['image'],
                        title: movie.data()['name'],
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ContentMovieScreen(
                                idMovie: movie.data()['id_movie'],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                }

                return GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: _isList ? 1 : 3,
                    childAspectRatio: _isList ? 3 : 0.74,
                    mainAxisSpacing: 5,
                  ),
                  // physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                      vertical: 60.0, horizontal: _isList ? 10.0 : 0.0),
                  children: mListCardMoviesDisplay,
                );
              }),
          CardAppBarListGrid(
            title: '${widget.category}',
            hasBack: true,
            isList: _isList,
            onClick: (value) {
              setState(() {
                _isList = value;
              });
            },
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:panel_back_end/constants.dart';
import 'package:panel_back_end/screens/movies/add_movies.dart';
import 'package:panel_back_end/screens/movies/list_movies.dart';

class UploadMovies extends StatefulWidget {
  @override
  _UploadMoviesState createState() => _UploadMoviesState();
}

class _UploadMoviesState extends State<UploadMovies> {
  int indexPage = 0;
  List<Widget> mListPages = [
    ListMovies(),
    AddMovies(),
  ];

  @override
  Widget build(BuildContext context) {
    final mSize = MediaQuery.of(context).size;
    return Container(
      width: mSize.width,
      height: mSize.height,
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              indicatorColor: kColorPrimary,
              isScrollable: false,
              labelColor: kColorPrimary,
              onTap: (index) {
                setState(() {
                  indexPage = index;
                });
              },
              tabs: [
                Tab(
                  text: 'List Movies',
                ),
                Tab(
                  text: 'Add Movies',
                ),
              ],
            ),
            Flexible(
              child: mListPages[indexPage],
            ),
          ],
        ),
      ),
    );
  }
}

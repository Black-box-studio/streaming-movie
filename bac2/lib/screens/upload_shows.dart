import 'package:flutter/material.dart';
import 'package:panel_back_end/screens/shows/add_shows.dart';
import 'package:panel_back_end/screens/shows/list_shows.dart';

import '../constants.dart';

class UploadShows extends StatefulWidget {
  @override
  _UploadShowsState createState() => _UploadShowsState();
}

class _UploadShowsState extends State<UploadShows> {
  int indexPage = 0;
  List<Widget> mListPages = [
    ListShows(),
    AddShows(),
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
                  text: 'List Shows',
                ),
                Tab(
                  text: 'Add Shows',
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

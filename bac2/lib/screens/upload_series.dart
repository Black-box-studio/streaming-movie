import 'package:flutter/material.dart';
import 'package:panel_back_end/screens/series/add_series.dart';
import 'package:panel_back_end/screens/series/list_series.dart';

import '../constants.dart';


class UploadSeries extends StatefulWidget {
  @override
  _UploadSeriesState createState() => _UploadSeriesState();
}

class _UploadSeriesState extends State<UploadSeries> {
  int indexPage = 0;
  List<Widget> mListPages = [
    ListSeries(),
    AddSeries(),
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
                  text: 'List Series',
                ),
                Tab(
                  text: 'Add Series',
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

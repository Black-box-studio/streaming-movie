import 'package:flutter/material.dart';
import 'package:panel_back_end/screens/theTop/pick_top.dart';
import 'package:panel_back_end/screens/theTop/top_list.dart';

import '../constants.dart';

class UploadTheTop extends StatefulWidget {
  @override
  _UploadTheTopState createState() => _UploadTheTopState();
}

class _UploadTheTopState extends State<UploadTheTop> {
  int indexPage = 0;
  List<Widget> mListPages = [
    TopList(),
    PickTop(),
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
                  text: 'The Top List',
                ),
                Tab(
                  text: 'Pick Top Movies',
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

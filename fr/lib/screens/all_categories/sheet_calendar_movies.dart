import 'package:azul_movies/constants.dart';
import 'package:azul_movies/localization/localization_constans.dart';
import 'package:azul_movies/models/database.dart';

import 'package:azul_movies/screens/content/content_movie_screen.dart';
import 'package:azul_movies/screens/main/favorite_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SheetCalendarMovies extends StatefulWidget {
  @override
  _SheetCalendarMoviesState createState() => _SheetCalendarMoviesState();
}

class _SheetCalendarMoviesState extends State<SheetCalendarMovies> {
  var _timeSelected;
  var _localCalendar = 'en'; //default
  var _controller = DatePickerController();

  @override
  void initState() {
    getLocaleToCalendar();
    _timeSelected = DateFormat("dd-MM-yyyy").format(DateTime.now());
    super.initState();
  }

  getLocaleToCalendar() async {
    SharedPreferences _perfs = await SharedPreferences.getInstance();
    String codeLanguege = _perfs.getString(LANGUEGE_CODE) ?? 'en';

    setState(() {
      _localCalendar = codeLanguege;
    });
  }

  @override
  Widget build(BuildContext context) {
    ///Size Layout
    final mSize = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 70.0),
        child: FloatingActionButton(
          child: Icon(
            FontAwesomeIcons.calendarDay,
            color: Colors.white,
          ),
          onPressed: () {
            _controller.animateToSelection();
          },
        ),
      ),
      backgroundColor: kColorRed01,
      body: Container(
        width: mSize.width,
        child: Stack(
          children: [
            Container(
              color: Theme.of(context).primaryColor,
              width: mSize.width,
              height: mSize.height,
              margin: EdgeInsets.only(
                top: 90.0,
              ),
              child: StreamBuilder<QuerySnapshot>(
                  stream:
                      Database.getTimePosts(time: _timeSelected, isEqual: true),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Padding(
                          padding: EdgeInsets.symmetric(vertical: 15.0),
                          child: LinearProgressIndicator());
                    }

                    final mPosts = snapshot.data.docs;

                    if (mSize.isEmpty) {
                      return Padding(
                          padding: EdgeInsets.symmetric(vertical: 15.0),
                          child: Center(child: Text('Empty...')));
                    }

                    List<CardMoviesDisplay> mListCardMoviesDisplay = [];

                    for (var post in mPosts) {
                      mListCardMoviesDisplay.add(
                        CardMoviesDisplay(
                          isDirectionLTR: !isLayoutRTL(context),
                          image: post.data()['image'],
                          title: post.data()['name'],
                          body: post.data()['summary'],
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ContentMovieScreen(
                                  idMovie: post.id,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }

                    return ListView(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.only(
                          top: 15.0, bottom: 70.0, left: 10.0, right: 10.0),
                      children: mListCardMoviesDisplay,
                    );
                  }),
            ),
            CardCalendarSheet(
              mSize: mSize,
              controller: _controller,
              local: _localCalendar,
              selectedDate: (date) {
                print(date);
                setState(() {
                  _timeSelected = DateFormat("dd-MM-yyyy").format(date);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CardCalendarSheet extends StatelessWidget {
  final mSize;
  final local;
  final controller;
  final Function selectedDate;

  CardCalendarSheet({
    @required this.mSize,
    @required this.selectedDate,
    @required this.local,
    @required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final dateNow = DateTime.now();
    final yesterdaySixThirty =
        DateTime(dateNow.year, dateNow.month, dateNow.day - 10, 0, 0);
    return Container(
      width: mSize.width,
      height: 105.0,
      padding: EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        color: kColorRed01,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15.0),
          bottomRight: Radius.circular(15.0),
        ),
      ),
      child: DatePicker(
        yesterdaySixThirty,
        initialSelectedDate: dateNow,
        controller: controller,
        selectionColor: kColorBlack02,
        selectedTextColor: Colors.white,
        width: 60.0,
        locale: local,
        dateTextStyle: TextStyle(fontSize: 11.0, color: Colors.white60),
        dayTextStyle: TextStyle(fontSize: 12.0, color: Colors.white60),
        monthTextStyle: TextStyle(fontSize: 11.0, color: Colors.white60),
        onDateChange: selectedDate,
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:panel_back_end/constants.dart';
import 'package:panel_back_end/models/databse.dart';
import 'package:panel_back_end/models/delete.dart';
import 'package:panel_back_end/models/upload.dart';
import 'package:panel_back_end/widgets/card_editor.dart';
import 'package:panel_back_end/widgets/cards_snackBar.dart';
import 'package:panel_back_end/widgets/cards_the_top.dart';
import 'package:panel_back_end/widgets/inputs_main.dart';

class PickTop extends StatefulWidget {
  @override
  _PickTopState createState() => _PickTopState();
}

class _PickTopState extends State<PickTop> {
  var _searchName = ''; //Empty by default
  var _type; // null by default

  var _selectedList;

  @override
  Widget build(BuildContext context) {
    final mSize = MediaQuery.of(context).size;
    return Container(
      width: mSize.width,
      height: mSize.height,
      child: Row(
        children: [
          Container(
            width: 200.0,
            height: mSize.height,
            decoration: BoxDecoration(
              color: kColorWhite01,
              boxShadow: kShadow01,
            ),
            //Drawer List Pick
            child: StreamBuilder<QuerySnapshot>(
                stream: Database.getListTheTop(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return LinearProgressIndicator();
                  }

                  final mData = snapshot.data.docs;

                  if (mData.isEmpty) {
                    return Text('Upload some List first...');
                  }
                  List<CardPick> mListCardPick = [];

                  for (var list in mData) {
                    mListCardPick.add(
                      CardPick(
                        label: list.data()['title'],
                        isSelected: _selectedList == list.id,
                        onTap: () {
                          setState(() {
                            _selectedList = list.id;
                          });
                        },
                      ),
                    );
                  }

                  return SingleChildScrollView(
                    child: Column(
                      children: mListCardPick,
                    ),
                  );
                }),
          ),
          Expanded(
            child: Container(
              width: mSize.width,
              height: mSize.height,
              child: Stack(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 25.0),
                        Text(
                          "You picked:",
                          style: TextStyle(
                            color: kColorGrey04,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 15.0),
                        StreamBuilder<QuerySnapshot>(
                            stream: Database.getListPickTheTop(
                                document: _selectedList),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return LinearProgressIndicator();
                              }

                              final mData = snapshot.data.docs;

                              if (mData.isEmpty) {
                                return Text(
                                  "Pick ( Movies / Shows / Series )",
                                  style: TextStyle(
                                    color: kColorPrimary,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                );
                              }

                              List<CardSimpleMovies> mListCardSimpleMovies = [];

                              for (var movie in mData) {
                                mListCardSimpleMovies.add(
                                  CardSimpleMovies(
                                    image: movie.data()['image'],
                                    name: movie.data()['name'],
                                    isSelected: true,
                                    onDelete: () async {
                                      showConfirmeDialog(
                                          context: context,
                                          message: movie.data()['name'],
                                          action: () async {
                                            await Deletes.removeTheTop(
                                                document: _selectedList,
                                                pickId: movie.id,
                                                context: context);
                                          });
                                    },
                                  ),
                                );
                              }

                              return SizedBox(
                                width: mSize.width,
                                height: 190.0,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: mListCardSimpleMovies,
                                ),
                              );
                            }),
                        SizedBox(height: 15.0),
                        Text(
                          "MOVIES & SERIES & SHOWS",
                          style: TextStyle(
                            color: kColorGrey04,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 15.0),
                        //Posts
                        Flexible(
                          child: SingleChildScrollView(
                            child: StreamBuilder<QuerySnapshot>(
                                stream: Database.getPosts(
                                    search: _searchName, type: _type),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return LinearProgressIndicator();
                                  }

                                  final mData = snapshot.data.docs;

                                  if (mData.isEmpty) {
                                    return Text(
                                      "Upload some ( Movies / Shows / Series )",
                                      style: TextStyle(
                                        color: kColorPrimary,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    );
                                  }

                                  List<CardSimpleMovies> mListCardSimpleMovies =
                                      [];

                                  for (var movie in mData) {
                                    mListCardSimpleMovies.add(
                                      CardSimpleMovies(
                                        image: movie.data()['image'],
                                        name: movie.data()['name'],
                                        isSelected: false,
                                        onPick: () async {
                                          print(movie.data()['name']);
                                          if (_selectedList != null &&
                                              _selectedList != '') {
                                            await Upload.uploadMovieToTheTop(
                                              document: _selectedList,
                                              summary: movie.data()['summary'],
                                              name: movie.data()['name'],
                                              image: movie.data()['image'],
                                              idMovie: movie.id,
                                            );
                                          } else {
                                            showSnackBar(context,
                                                'Select Category from List First!!!');
                                          }
                                        },
                                      ),
                                    );
                                  }

                                  return Wrap(
                                    runSpacing: 10.0,
                                    spacing: 10.0,
                                    children: mListCardSimpleMovies,
                                  );
                                }),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: InputSearchMoviesAndSeries(
                      mSize: mSize,
                      selectType: (indexType) {
                        setState(() {
                          if (indexType == null) {
                            _type = null;
                          }
                          if (indexType == 0) {
                            _type = 'movie';
                          }
                          if (indexType == 1) {
                            _type = 'serie';
                          }
                          if (indexType == 2) {
                            _type = 'show';
                          }
                        });
                        print(_type);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

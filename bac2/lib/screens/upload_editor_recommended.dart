import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:panel_back_end/constants.dart';
import 'package:panel_back_end/models/databse.dart';
import 'package:panel_back_end/models/delete.dart';
import 'package:panel_back_end/models/upload.dart';
import 'package:panel_back_end/widgets/card_editor.dart';
import 'package:panel_back_end/widgets/cards_snackBar.dart';
import 'package:panel_back_end/widgets/inputs_main.dart';

class UploadEditorAndRecommended extends StatefulWidget {
  final isEditor;
  UploadEditorAndRecommended({@required this.isEditor});

  @override
  _UploadEditorAndRecommendedState createState() =>
      _UploadEditorAndRecommendedState();
}

class _UploadEditorAndRecommendedState
    extends State<UploadEditorAndRecommended> {
  var _searchName = ''; //Empty by default
  var _type; // null by default

  @override
  Widget build(BuildContext context) {
    final mSize = MediaQuery.of(context).size;

    return Container(
      width: mSize.width,
      height: mSize.height,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
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
                    stream: Database.getRecommenededAndEditorShooses(
                        type:
                            widget.isEditor ? 'EditorShooses' : 'Recommended'),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return LinearProgressIndicator();
                      }

                      final mData = snapshot.data.docs;

                      if (mData.isEmpty) {
                        return Text(
                          "Pick only 5 ( Movies / Shows / Series )",
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
                            onDelete: () async {
                              showConfirmeDialog(
                                  context: context,
                                  message: movie.data()['name'],
                                  action: () async {
                                    print('Delete: ${movie.data()['name']}');
                                    await Deletes.removePickPost(
                                        isEditore: widget.isEditor,
                                        document: movie.id,
                                        context: context);
                                  });
                            },
                            image: movie.data()['image'],
                            name: movie.data()['name'],
                            isSelected: true,
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
                  "MOVIES & SERIES & SHOWS <= 5",
                  style: TextStyle(
                    color: kColorGrey04,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 15.0),
                Flexible(
                  child: SingleChildScrollView(
                    child: StreamBuilder<QuerySnapshot>(
                        stream:
                            Database.getPosts(search: _searchName, type: _type),
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

                          List<CardSimpleMovies> mListCardSimpleMovies = [];

                          for (var movie in mData) {
                            mListCardSimpleMovies.add(
                              CardSimpleMovies(
                                onPick: () async {
                                  print('Pick: ${movie.data()['name']}');

                                  final isUploaded =
                                      await Upload.uploadPickedTypeMovie(
                                    idMovie: movie.id,
                                    image: movie.data()['image'],
                                    name: movie.data()['name'],
                                    summary: movie.data()['summary'],
                                    isEditore: widget.isEditor,
                                  );

                                  if (isUploaded) {
                                    print('Uplaoded Seccsus');
                                  }
                                },
                                image: movie.data()['image'],
                                name: movie.data()['name'],
                                isSelected: false,
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
    );
  }
}

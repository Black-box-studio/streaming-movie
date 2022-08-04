import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:panel_back_end/models/databse.dart';
import 'package:panel_back_end/models/delete.dart';
import 'package:panel_back_end/widgets/cards_movies.dart';
import 'package:panel_back_end/widgets/cards_snackBar.dart';
import 'package:panel_back_end/widgets/dialogs/dialog_server.dart';
import 'package:panel_back_end/widgets/inputs_main.dart';

import '../../constants.dart';
import 'edit_movie.dart';

class ListMovies extends StatefulWidget {
  @override
  _ListMoviesState createState() => _ListMoviesState();
}

class _ListMoviesState extends State<ListMovies> {
  var _timeMap;
  var _searchTxt;

  @override
  void initState() {
    //_timeMap = getDateFormat(DateTime.now());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //1190
    final mSize = MediaQuery.of(context).size;
    bool isSmall = mSize.width > 1190;
    //print(mSize.width);
    return Stack(
      children: [
        Container(
          width: mSize.width,
          height: mSize.height,
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  children: [
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Center(child: TileTXT('#'))),
                    Expanded(flex: 2, child: Center(child: TileTXT('Image'))),
                    Expanded(flex: 2, child: Center(child: TileTXT('Name'))),
                    isSmall
                        ? Expanded(
                            flex: 2,
                            child: Center(child: TileTXT('Categories')))
                        : SizedBox(),
                    Expanded(flex: 3, child: Center(child: TileTXT('Summary'))),
                    Expanded(flex: 2, child: Center(child: TileTXT('Action'))),
                  ],
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: Database.getMoviesType(
                      type: 'movie', timeMap: _timeMap, search: _searchTxt),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return LinearProgressIndicator();
                    }
                    if (snapshot.hasError) {
                      print(snapshot.error);
                      showSnackBar(context, snapshot.error);
                      return Text('${snapshot.error}');
                    }

                    final mMovies = snapshot.data.docs;

                    if (mMovies.isEmpty) {
                      return Text('Empty...');
                    }

                    List<CardMovies> mListCardMovies = [];

                    for (var i = 0; i < mMovies.length; i++) {
                      mListCardMovies.add(
                        CardMovies(
                          number: i + 1,
                          image: mMovies[i].data()['image'],
                          name: mMovies[i].data()['name'],
                          summary: mMovies[i].data()['summary'],
                          categories: mMovies[i].data()['categories'],
                          onDelete: () {
                            showConfirmeDialog(
                                context: context,
                                message: mMovies[i].data()['name'],
                                action: () async {
                                  await Deletes.removeMovie(
                                      document: mMovies[i].id,
                                      context: context);
                                });
                          },
                          onEdit: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditMovie(
                                  idMovie: mMovies[i].id,
                                ),
                              ),
                            );
                          },
                          onAdd: () {
                            showDialog(
                              context: context,
                              builder: (context) => DialogMoviesServers(
                                nameEpisode: mMovies[i].data()['name'],
                                idMovie: mMovies[i].id,
                              ),
                            );
                          },
                        ),
                      );
                    }

                    return Flexible(
                      child: ListView(
                        children: mListCardMovies,
                      ),
                    );
                  }),
            ],
          ),
        ),
        InputSearchMovies(
          mSize: mSize,
          value: (val) {
            setState(() {
              _searchTxt = val;
            });
          },
          onSearch: () {
            print(capitalize(_searchTxt));
          },
        ),
      ],
    );
  }
}

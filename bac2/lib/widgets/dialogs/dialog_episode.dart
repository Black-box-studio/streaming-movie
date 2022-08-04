import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:panel_back_end/constants.dart';
import 'package:panel_back_end/models/databse.dart';
import 'package:panel_back_end/models/delete.dart';
import 'package:panel_back_end/models/upload.dart';
import 'package:panel_back_end/widgets/cards_snackBar.dart';
import 'package:panel_back_end/widgets/dialogs/dialog_server.dart';

class DialogMoviesEpisodes extends StatefulWidget {
  final nameEpisode;
  final idMovie;

  DialogMoviesEpisodes({
    this.nameEpisode,
    this.idMovie,
  });

  @override
  _DialogMoviesEpisodesState createState() => _DialogMoviesEpisodesState();
}

class _DialogMoviesEpisodesState extends State<DialogMoviesEpisodes> {
  var _searchKey = '';
  var _newEpisode = TextEditingController();
  bool isRevers = false;
  bool progress = false;

  @override
  Widget build(BuildContext context) {
    final mSize = MediaQuery.of(context).size;
    return AlertDialog(
      contentPadding: EdgeInsets.all(0.0),
      content: Container(
        width: mSize.width / 2,
        height: 500.0,
        child: Column(
          children: [
            InputDialogSearch(
              mSize: mSize,
              value: (value) {
                setState(() {
                  _searchKey = value;
                });
              },
              onTap: () {
                setState(() {
                  isRevers = !isRevers;
                });
                print(isRevers);
              },
            ),
            Flexible(
              child: StreamBuilder<QuerySnapshot>(
                  stream: Database.getEpisodes(
                      idMovie: widget.idMovie, search: _searchKey),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return LinearProgressIndicator();
                    }

                    final mEpisodes = isRevers
                        ? snapshot.data.docs
                        : snapshot.data.docs.reversed;

                    if (mEpisodes.isEmpty) {
                      return Center(child: Text('Empty...'));
                    }

                    List<CardEpisodeRaw> mListCardEpisodeRaw = [];

                    for (var episod in mEpisodes) {
                      mListCardEpisodeRaw.add(
                        CardEpisodeRaw(
                          mSize: mSize,
                          label: episod.data()['title'].toString(),
                          onDelete: () {
                            showConfirmeDialog(
                              context: context,
                              message: episod.data()['title'].toString(),
                              action: () async {
                                await Deletes.removeEpisode(
                                    idMovie: widget.idMovie,
                                    idEpisod: episod.id,
                                    context: context);
                              },
                            );
                          },
                          onEdit: () {
                            showDialog(
                              context: context,
                              builder: (context) => DialogMoviesServers(
                                isSerie: true,
                                nameEpisode: episod.data()['title'].toString(),
                                idMovie: widget.idMovie,
                                idEpisod: episod.id,
                              ),
                            );
                          },
                        ),
                      );
                    }

                    return ListView(
                      // reverse: isRevers,
                      padding: EdgeInsets.all(10.0),
                      children: mListCardEpisodeRaw,
                    );
                  }),
            ),
            progress ? LinearProgressIndicator() : SizedBox(),
            InputDialogAddEpisode(
              controller: _newEpisode,
              onUpload: () async {
                setState(() {
                  progress = true;
                });
                final bool _upload = await Upload.uploadEpisode(
                    idMovie: widget.idMovie, title: _newEpisode.text);

                if (_upload) {
                  print('Uploaded.');
                  setState(() {
                    _newEpisode.clear();
                  });
                }
                setState(() {
                  progress = false;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class InputDialogAddEpisode extends StatelessWidget {
  final controller;
  final Function onUpload;
  InputDialogAddEpisode({this.controller, this.onUpload});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35.0,
      width: double.infinity,
      color: kColorGrey05,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              cursorColor: kColorPrimary,
              decoration: InputDecoration(
                hintText: 'New Name Episode',
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(bottom: 10.0, left: 15.0),
                hintStyle: TextStyle(
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: onUpload,
            child: Container(
              width: 40.0,
              height: 35.0,
              color: Colors.green,
              child: Center(
                child: Icon(
                  FontAwesomeIcons.plus,
                  size: 15.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CardEpisodeRaw extends StatelessWidget {
  const CardEpisodeRaw({
    this.label,
    this.mSize,
    this.onDelete,
    this.onEdit,
  });

  final Size mSize;
  final onEdit;
  final onDelete;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: mSize.width,
      height: 34.0,
      margin: EdgeInsets.only(bottom: 5.0),
      decoration: BoxDecoration(
        border: Border.all(color: kColorPrimary, width: 0.5),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Row(
        children: [
          SizedBox(width: 15.0),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: kColorPrimary,
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          CardEditRawSmall(
            icon: FontAwesomeIcons.edit,
            color: Colors.orangeAccent,
            onTap: onEdit,
          ),
          CardEditRawSmall(
            icon: FontAwesomeIcons.trash,
            color: Colors.red,
            onTap: onDelete,
          ),
        ],
      ),
    );
  }
}

class CardEditRawSmall extends StatelessWidget {
  const CardEditRawSmall({
    this.icon,
    this.onTap,
    this.color,
  });

  final icon, onTap;
  final color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 40.0,
        height: double.infinity,
        color: color,
        child: Icon(
          icon,
          color: Colors.white,
          size: 15.0,
        ),
      ),
    );
  }
}

class InputDialogSearch extends StatelessWidget {
  const InputDialogSearch({
    @required this.mSize,
    this.value,
    this.onTap,
  });

  final Size mSize;
  final Function value;
  final onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: mSize.width,
      height: 40.0,
      child: Material(
        color: kColorPrimary,
        elevation: 0.5,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  onChanged: value,
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                  decoration: InputDecoration(
                    hintText: 'search...',
                    hintStyle: TextStyle(color: kColorGrey05, fontSize: 15.0),
                    enabledBorder: InputBorder.none,
                    border: InputBorder.none,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.sort,
                  color: Colors.white,
                  size: 18.0,
                ),
                onPressed: onTap,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InputDialogBar extends StatelessWidget {
  const InputDialogBar({
    @required this.mSize,
    @required this.label,
    this.onTap,
  });

  final Size mSize;
  final label;
  final onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: mSize.width,
      height: 40.0,
      child: Material(
        color: kColorPrimary,
        elevation: 0.5,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            children: [
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.chevronLeft,
                  color: Colors.white,
                  size: 18.0,
                ),
                onPressed: () => Navigator.pop(context),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    label,
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

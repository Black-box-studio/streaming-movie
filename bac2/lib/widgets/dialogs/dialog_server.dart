import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:panel_back_end/models/databse.dart';
import 'package:panel_back_end/models/delete.dart';
import 'package:panel_back_end/models/upload.dart';
import 'package:panel_back_end/widgets/cards_snackBar.dart';
import 'package:panel_back_end/widgets/dialogs/dialog_episode.dart';

import '../../constants.dart';

class DialogMoviesServers extends StatefulWidget {
  final nameEpisode;
  final idMovie;
  final idEpisod;
  final isSerie;

  DialogMoviesServers({
    this.nameEpisode,
    @required this.idMovie,
    this.isSerie = false,
    this.idEpisod,
  });

  @override
  _DialogMoviesServersState createState() => _DialogMoviesServersState();
}

class _DialogMoviesServersState extends State<DialogMoviesServers> {
  var _link = TextEditingController();
  var _name = TextEditingController();

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
            InputDialogBar(
              mSize: mSize,
              label: '${widget.nameEpisode}',
              onTap: () {
                //top to bottom
              },
            ),
            Flexible(
              child: StreamBuilder<QuerySnapshot>(
                  stream: Database.getServers(
                      idMovie: widget.idMovie,
                      isSerie: widget.isSerie,
                      idEpisod: widget.idEpisod),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return LinearProgressIndicator();
                    }

                    final mServers = snapshot.data.docs;

                    if (mServers.isEmpty) {
                      return Center(child: Text('Empty...'));
                    }

                    List<CardServerRaw> mListCardServerRaw = [];

                    for (var server in mServers) {
                      mListCardServerRaw.add(
                        CardServerRaw(
                          mSize: mSize,
                          label: server.data()['name'],
                          onDelete: () {
                            showConfirmeDialog(
                                context: context,
                                message: server.data()['name'],
                                action: () async {
                                  await Deletes.removeServer(
                                    context: context,
                                    idMovie: widget.idMovie,
                                    idSever: server.id,
                                    isEpisode: widget.idEpisod,
                                    isSerie: widget.isSerie,
                                  );
                                });
                          },
                        ),
                      );
                    }

                    return ListView(
                      padding: EdgeInsets.all(10.0),
                      children: mListCardServerRaw,
                    );
                  }),
            ),
            progress ? LinearProgressIndicator() : SizedBox(),
            InputDialogAddServer(
              controllerLink: _link,
              controllerName: _name,
              onUpload: () async {
                setState(() {
                  progress = true;
                });
                bool _upload = await Upload.uploadServer(
                  idMovie: widget.idMovie,
                  link: _link.text,
                  name: _name.text,
                  isSerie: widget.isSerie,
                  idEpisod: widget.idEpisod,
                );

                if (_upload) {
                  print('Data Uploaded Seccusfuly.');
                  setState(() {
                    _link.clear();
                    _name.clear();
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

class CardServerRaw extends StatelessWidget {
  const CardServerRaw({
    this.label,
    this.mSize,
    this.onDelete,
  });

  final Size mSize;

  final onDelete;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: mSize.width,
      height: 34.0,
      margin: EdgeInsets.only(bottom: 10.0),
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
            icon: FontAwesomeIcons.trash,
            color: Colors.red,
            onTap: onDelete,
          ),
        ],
      ),
    );
  }
}

class InputDialogAddServer extends StatelessWidget {
  final controllerName, controllerLink;
  final Function onUpload;
  InputDialogAddServer(
      {this.controllerName, this.controllerLink, this.onUpload});

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
              controller: controllerName,
              cursorColor: kColorPrimary,
              decoration: InputDecoration(
                hintText: 'Name Server ex: ( 1080p )',
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(bottom: 10.0, left: 15.0),
                hintStyle: TextStyle(
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
          SizedBox(width: 15.0),
          Expanded(
            flex: 3,
            child: TextField(
              controller: controllerLink,
              cursorColor: kColorPrimary,
              decoration: InputDecoration(
                hintText: 'Server Link',
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

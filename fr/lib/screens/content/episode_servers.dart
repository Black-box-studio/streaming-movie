import 'package:azul_movies/constants.dart';
import 'package:azul_movies/models/database.dart';
import 'package:azul_movies/screens/players/azul_player_screen.dart';
import 'package:azul_movies/screens/players/speed_player_screen.dart';
import 'package:azul_movies/widgets/widgets_toolbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EpisodesServersScreen extends StatefulWidget {
  final idDocument;
  final idEpisode;
  final bool isMovie;

  EpisodesServersScreen({
    this.idDocument,
    this.idEpisode,
    @required this.isMovie,
  });

  @override
  _EpisodesServersScreenState createState() => _EpisodesServersScreenState();
}

class _EpisodesServersScreenState extends State<EpisodesServersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 60.0, horizontal: 10.0),
                child: StreamBuilder<QuerySnapshot>(
                    stream: Database.getServers(
                      isMovie: widget.isMovie,
                      idDocument: widget.idDocument,
                      idEpisode: widget.idEpisode,
                    ),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return LinearProgressIndicator();
                      }

                      final mServers = snapshot.data.docs;
                      List<CardServers> mListCardServer = [];

                      if (mServers.isEmpty) {
                        return Center(child: Text('Empty...'));
                      }

                      for (var server in mServers) {
                        mListCardServer.add(
                          CardServers(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => DialogServer(
                                  linkStream: server.data()['server'],
                                  title: server.data()['name'],
                                ),
                              );
                            },
                            title: server.data()['name'],
                          ),
                        );
                      }

                      return Column(
                        children: mListCardServer,
                      );
                    }),
              ),
            ),
            CardAppBarRed(
              title: getTranslationText(context, 'servers') ?? 'Servers',
              hasBack: true,
            ),
          ],
        ),
      ),
    );
  }
}

class CardServers extends StatelessWidget {
  final Function onTap;
  final String title;

  CardServers({
    @required this.onTap,
    @required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 10.0),
          decoration: BoxDecoration(
            color: kColorRed01,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Center(
            child: Text(
              '$title',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DialogServer extends StatelessWidget {
  final linkStream;
  final title;

  DialogServer({@required this.linkStream, this.title});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).primaryColor,
      title: Text(
        getTranslationText(context, 'select_player'),
        style: TextStyle(fontSize: 20.0),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CardServers(
            title: 'Speed Player',
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => SpeedPlayer(
                    title: title,
                    linkStream: linkStream,
                  ),
                ),
              );
            },
          ),
          CardServers(
            title: 'Azul Player',
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => AzulPlayer(
                    title: title,
                    linkStream: linkStream,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

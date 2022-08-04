import 'package:azul_movies/constants.dart';
import 'package:azul_movies/models/database.dart';
import 'package:azul_movies/screens/content/episode_servers.dart';
import 'package:azul_movies/widgets/widgets_toolbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EpisodesScreen extends StatefulWidget {
  final idDocument;
  EpisodesScreen({@required this.idDocument});

  @override
  _EpisodesScreenState createState() => _EpisodesScreenState();
}

class _EpisodesScreenState extends State<EpisodesScreen> {
  bool fromStartToEnd = false;

  @override
  Widget build(BuildContext context) {
    ///Size Layout
    final mSize = MediaQuery.of(context).size;
    double _width = mSize.width;
    //final isWidth = _width > MINWIDTHSCREEN;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: _width,
              height: mSize.height,
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 60.0, horizontal: 10.0),
                  child: Column(
                    children: [
                      StreamBuilder<QuerySnapshot>(
                        stream:
                            Database.getEpisodes(idDocument: widget.idDocument),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return LinearProgressIndicator();
                          }

                          final mEpisodes = fromStartToEnd
                              ? snapshot.data.docs
                              : snapshot.data.docs.reversed;

                          if (mEpisodes.isEmpty) {
                            return Center(child: Text('Empty...'));
                          }

                          List<CardEpisode> mListCardEpisode = [];

                          for (var episode in mEpisodes) {
                            mListCardEpisode.add(
                              CardEpisode(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          EpisodesServersScreen(
                                        isMovie: false,
                                        idDocument: widget.idDocument,
                                        idEpisode: episode.id,
                                      ),
                                    ),
                                  );
                                },
                                title:
                                    episode['title'].toString() ?? 'Episode ..',
                              ),
                            );
                          }

                          return Column(
                            //reverse: fromStartToEnd,
                            children: mListCardEpisode,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            CardAppBarRed(
              title: getTranslationText(context, 'episodes') ?? 'Episodes',
              hasBack: true,
              hasActionRight: true,
              onClick: () {
                setState(() {
                  fromStartToEnd == true
                      ? fromStartToEnd = false
                      : fromStartToEnd = true;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CardEpisode extends StatelessWidget {
  final Function onTap;
  final String title;

  CardEpisode({
    @required this.onTap,
    @required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          width: double.infinity,
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
              child: Text(
                '$title',
                style: TextStyle(
                  fontSize: 14.0,
                ),
              )),
        ),
      ),
    );
  }
}

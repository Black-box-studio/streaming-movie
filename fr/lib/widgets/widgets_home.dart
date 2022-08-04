import 'package:azul_movies/models/database.dart';
import 'package:azul_movies/screens/content/content_movie_screen.dart';
import 'package:azul_movies/widgets/card_visible.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:azul_movies/constants.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CardCarouselHome extends StatelessWidget {
  final image;
  final title;

  final isMovie;

  final idMovie;

  CardCarouselHome({
    @required this.image,
    @required this.title,
    @required this.isMovie,
    @required this.idMovie,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ContentMovieScreen(
              idMovie: idMovie,
            ),
          ),
        );
      },
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Container(
              width: double.infinity,
              height: 180.0,
              decoration: BoxDecoration(
                color: kColorBlack02,
                boxShadow: [kBoxShadow01],
              ),
              child: CachedNetworkImage(
                imageUrl: image,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) {
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 180.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.transparent,
                      Colors.black
                    ])),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 25.0, color: Colors.white),
                ),
                !isMovie
                    ? FutureBuilder(
                        future: Database.getSizeEpisodes(document: idMovie),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return SizedBox();
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return Text(
                              '${getTranslationText(context, 'episode')} ${snapshot.data}',
                              style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w200),
                            );
                          }
                          return Text('Episodes...');
                        })
                    : SizedBox(),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
                    child: Icon(
                        isMovie ? FontAwesomeIcons.tv : FontAwesomeIcons.film,
                        size: 15.0,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CardListMovie extends StatelessWidget {
  final title;
  final image;

  final onTap;

  CardListMovie({
    @required this.title,
    @required this.image,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 115.0,
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            Expanded(
              child: Material(
                borderRadius: BorderRadius.circular(8.0),
                elevation: 5.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: CachedNetworkImage(
                    imageUrl: image,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    placeholder: (context, url) {
                      return Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
              ),
            ),
            CardVisible(
              isVisible: title != '',
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
                child: RichText(
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  text: TextSpan(
                      text: title,
                      style: TextStyle(
                          fontSize: 12.0,
                          color: Theme.of(context).primaryColorDark)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

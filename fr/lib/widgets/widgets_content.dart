import 'package:azul_movies/constants.dart';
import 'package:azul_movies/screens/content/episode_servers.dart';

import 'package:azul_movies/screens/content/episodes_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'card_visible.dart';

class CardActionBarMovies extends StatelessWidget {
  final image;
  final date, time, status, episode;
  final List<CardBarHachtge> listCategories;
  final isThemDark;
  final bool isMovie;
  final idDocument;

  CardActionBarMovies({
    this.image,
    this.date,
    this.time,
    this.status,
    this.episode,
    this.listCategories,
    @required this.isMovie,
    @required this.isThemDark,
    @required this.idDocument,
  });

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      background: Stack(
        children: [
          CardVisible(
            isVisible: image != '',
            child: CachedNetworkImage(
              imageUrl: image,
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              placeholder: (context, url) {
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              color: kColorRed01,
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  isThemDark
                      ? Colors.black26.withOpacity(0.2)
                      : Colors.white.withOpacity(0.4),
                  isThemDark ? kColorBlack02 : Colors.white,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 130.0,
                ),
                CircleAvatar(
                  maxRadius: 30.0,
                  backgroundColor: kColorRed01,
                  child: IconButton(
                    icon: Icon(
                      FontAwesomeIcons.play,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      //show Episodes
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => isMovie
                              ? EpisodesServersScreen(
                                  isMovie: true,
                                  idDocument: idDocument,
                                )
                              : EpisodesScreen(idDocument: idDocument),
                        ),
                      );
                    },
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '$date',
                      style: TextStyle(fontSize: 14.0),
                    ),
                    SizedBox(height: 5.0),
                    CardVisible(
                      isVisible: listCategories.isNotEmpty,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Wrap(
                          spacing: 5.0,
                          runSpacing: 5.0,
                          alignment: WrapAlignment.center,
                          children: listCategories,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CardBarInfoMovie(
                          label: getTranslationText(context, 'minutes') ??
                              'Minutes',
                          body: '$time',
                        ),
                        CardBarInfoMovie(
                          label:
                              getTranslationText(context, 'status') ?? 'Status',
                          body: status,
                        ),
                        isMovie
                            ? SizedBox()
                            : CardBarInfoMovie(
                                label:
                                    getTranslationText(context, 'episodes') ??
                                        'Episodes',
                                body: '$episode',
                              ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CardBarInfoMovie extends StatelessWidget {
  final body;
  final label;

  CardBarInfoMovie({
    @required this.body,
    @required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Column(
        children: [
          Text(
            '$body',
            style: TextStyle(
              color: kColorRed01,
              fontSize: 15.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            '$label',
            style: TextStyle(
              // color: Colors.white,
              fontSize: 15.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class CardBarHachtge extends StatelessWidget {
  final caty;
  final onTap;
  final isStudio;

  CardBarHachtge({
    @required this.caty,
    this.onTap,
    this.isStudio = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.0),
        decoration: BoxDecoration(
          color: isStudio ? kColorBlack01 : kColorRed01,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Text(
          caty,
          style: TextStyle(fontSize: 12.0, color: Colors.white),
        ),
      ),
    );
  }
}

class CardRowInfoMovie extends StatelessWidget {
  final label, body;

  CardRowInfoMovie({
    @required this.label,
    @required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$label',
            style: kStyleTitle01.copyWith(
                color: Colors.white,
                fontSize: 12.0,
                fontWeight: FontWeight.w400),
          ),
          Text(
            '$body',
            style: kStyleTitle01.copyWith(color: Colors.white, fontSize: 15.0),
          ),
        ],
      ),
    );
  }
}

class CardImageCharacter extends StatelessWidget {
  final image;
  final name;
  final onTap;

  CardImageCharacter({@required this.image, @required this.name, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 65.0,
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: CachedNetworkImage(
                  imageUrl: image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            Text(
              '$name',
              maxLines: 1,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10.0, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class CardImageTrailer extends StatelessWidget {
  final keyImage;
  final onTap;

  CardImageTrailer({@required this.keyImage, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120.0,
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: CachedNetworkImage(
            imageUrl: 'https://i.ytimg.com/vi/$keyImage/maxresdefault.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            placeholder: (context, v) {
              return Center(
                  child: CircularProgressIndicator(
                backgroundColor: Colors.white,
              ));
            },
          ),
        ),
      ),
    );
  }
}

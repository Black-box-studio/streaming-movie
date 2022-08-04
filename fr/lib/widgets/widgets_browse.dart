import 'package:azul_movies/models/database.dart';
import 'package:azul_movies/screens/all_categories/all_movies_screen.dart';
import 'package:azul_movies/screens/content/content_movie_screen.dart';
import 'package:azul_movies/widgets/widgets_home.dart';
import 'package:azul_movies/widgets/widgets_main.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class CardCatyTile extends StatelessWidget {
  final title;
  final Function onPress;

  CardCatyTile({
    @required this.title,
    @required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return CardPadding(
      vertical: 10.0,
      horizontal: 15.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: kStyleTitle02.copyWith(fontSize: 16.0),
          ),
          InkWell(
            onTap: onPress,
            child: Text(
              getTranslationText(context, 'show_all'),
              style: kStyleTitle02.copyWith(color: kColorRed01, fontSize: 16.0),
            ),
          ),
        ],
      ),
    );
  }
}

class CardCatyListMovies extends StatelessWidget {
  final labelCaty;
  final idTheTop;

  CardCatyListMovies({
    this.labelCaty,
    this.idTheTop,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //TOP SHOWS
        CardCatyTile(
          title: labelCaty,
          onPress: () {
            //SHow All Movies
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AllMoviesScreen(
                  category: labelCaty,
                  idMovie: idTheTop,
                  isCategory: false,
                ),
              ),
            );
          },
        ),
        // Get Top Movies...
        StreamBuilder<QuerySnapshot>(
            stream: Database.getTheTopPosts(idDocument: idTheTop),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }

              final mMovies = snapshot.data.docs;

              if (mMovies.isEmpty) {
                return SizedBox();
              }

              List<CardListMovie> mListCardListMovie = [];

              for (var movie in mMovies) {
                mListCardListMovie.add(
                  CardListMovie(
                    image: movie.data()['image'],
                    title: movie.data()['name'],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ContentMovieScreen(
                            idMovie: movie.data()['id_movie'],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }

              return CardListItems(
                children: mListCardListMovie,
              );
            }),
        SizedBox(height: 15.0),
      ],
    );
  }
}

class CardRawCaty extends StatelessWidget {
  final title;
  final image;
  final onTap;

  CardRawCaty({
    @required this.title,
    @required this.image,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150.0,
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Stack(
            children: [
              CachedNetworkImage(
                imageUrl: image,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Center(
                  child: Text(
                    title,
                    style: TextStyle(color: Colors.white, fontSize: 14.0),
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

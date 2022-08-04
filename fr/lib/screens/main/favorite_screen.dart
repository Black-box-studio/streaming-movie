import 'package:azul_movies/screens/content/content_movie_screen.dart';
import 'package:azul_movies/sqlite/movies.dart';
import 'package:azul_movies/sqlite/sqlite.dart';
import 'package:azul_movies/widgets/widgets_toolbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../constants.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    final mSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                width: mSize.width,
                height: mSize.height,
                child: Column(
                  children: [
                    FutureBuilder<List<Movies>>(
                        future: DBProvider.db.getAllMovies(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Padding(
                              padding: EdgeInsets.only(top: 60.0),
                              child: Text(
                                getTranslationText(context, 'favorite_empty'),
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12.0),
                              ),
                            );
                          }

                          final mList = snapshot.data;

                          if (mList.isEmpty) {
                            return Padding(
                              padding: EdgeInsets.only(top: 60.0),
                              child: Text(
                                getTranslationText(context, 'favorite_empty'),
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12.0),
                              ),
                            );
                          }

                          return Flexible(
                            child: ListView.builder(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 60.0),
                              itemCount: mList.length,
                              itemBuilder: (context, index) {
                                return CardMoviesDisplay(
                                  isDirectionLTR: !isLayoutRTL(context),
                                  image: mList[index].image,
                                  title: mList[index].name,
                                  body: mList[index].summary,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ContentMovieScreen(
                                                idMovie: mList[index].id),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          );
                        }),
                    SizedBox(height: 35.0),
                  ],
                ),
              ),
              Positioned(
                child: CardAppBarRed(
                  title: getTranslationText(context, 'favorite'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardMoviesDisplay extends StatelessWidget {
  final bool isDirectionLTR;
  final image;
  final title, body;
  final onTap;

  CardMoviesDisplay({
    @required this.isDirectionLTR,
    @required this.image,
    @required this.title,
    @required this.body,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          children: [
            Material(
              elevation: 10.0,
              borderRadius: BorderRadius.circular(10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: CachedNetworkImage(
                  imageUrl: image,
                  width: 75.0,
                  height: 115.0,
                  fit: BoxFit.cover,
                  placeholder: (context, value) {
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                height: 70.0,
                padding: EdgeInsets.only(
                    left: isDirectionLTR ? 10.0 : 5,
                    right: isDirectionLTR ? 5.0 : 10.0),
                decoration: BoxDecoration(
                  color: kColorRed01,
                  boxShadow: [kBoxShadow02],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(isDirectionLTR ? 0 : 10.0),
                    bottomLeft: Radius.circular(isDirectionLTR ? 0 : 10.0),
                    bottomRight: Radius.circular(isDirectionLTR ? 10.0 : 0.0),
                    topRight: Radius.circular(isDirectionLTR ? 10.0 : 0.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      text: TextSpan(
                          text: title,
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.white)),
                    ),
                    SizedBox(height: 2.0),
                    RichText(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      text: TextSpan(
                          text: body,
                          style:
                              TextStyle(fontSize: 10.0, color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

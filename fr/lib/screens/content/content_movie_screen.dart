import 'package:azul_movies/constants.dart';
import 'package:azul_movies/models/database.dart';
import 'package:azul_movies/models/func.dart';
import 'package:azul_movies/models/subscribe.dart';
import 'package:azul_movies/provider/dark_them_stats.dart';
import 'package:azul_movies/screens/all_categories/all_movies_screen.dart';
import 'package:azul_movies/sqlite/movies.dart';
import 'package:azul_movies/widgets/card_visible.dart';
import 'package:azul_movies/widgets/widgets_content.dart';
import 'package:azul_movies/widgets/widgets_home.dart';
import 'package:azul_movies/widgets/widgets_main.dart';
import 'package:azul_movies/widgets/widgets_progress.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher.dart';

class ContentMovieScreen extends StatefulWidget {
  final idMovie;

  ContentMovieScreen({
    @required this.idMovie,
  });

  @override
  _ContentMovieScreenState createState() => _ContentMovieScreenState();
}

class _ContentMovieScreenState extends State<ContentMovieScreen>
    with SingleTickerProviderStateMixin {
  var _cardInfo = true; //Default
  bool isMovie = true;
  bool isSubscribe = false;

  var name = '';
  var image = '';
  var date = '';
  var time = '';
  var minutes = '';
  var episodes = '';
  var status = '';
  var summary = '';
  var format = '';
  var season = '';
  var source = '';
  var firstAired = '';
  var sizeEpisodes = 'wait...';
  List<CardBarHachtge> mListCardCategories = [];
  List<CardBarHachtge> mListCardStudio = [];
  List<String> arrayCategories = [];

  Future<void> getDataMovie() async {
    // print('ID MOVIE: ${widget.idMovie}');
    final mPost = await Database.getPost(document: widget.idMovie);
    final mSizeEpisodes =
        await Database.getSizeEpisodes(document: widget.idMovie);
    final mCategories = await Database.getArrayMovie(document: widget.idMovie);
    if (mounted)
      setState(() {
        name = mPost['name'] ?? '';
        image = mPost['image'] ?? '';
        date = mPost['date'] ?? '';
        time = mPost['time'] ?? '';
        minutes = mPost['minutes'] ?? '';
        episodes = mPost['episodes'] ?? '';
        status = mPost['status'] ?? '';
        summary = mPost['summary'] ?? '';
        format = mPost['format'] ?? '';
        season = mPost['season'] ?? '';
        source = mPost['source'] ?? '';
        isMovie = mPost['type'] == 'movie';
        firstAired = mPost['firstAired'] ?? '';
        sizeEpisodes = '$mSizeEpisodes' ?? '0';
      });

    for (int i = 0; i < mCategories.data()['categories'].length; i++) {
      var caty = mCategories.data()['categories'][i].toString();
      mListCardCategories.add(
        CardBarHachtge(
          caty: caty,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AllMoviesScreen(
                  isCategory: true,
                  category: caty,
                ),
              ),
            );
          },
        ),
      );
      arrayCategories.add(mCategories.data()['categories'][i].toString());
    }

    for (int i = 0; i < mCategories.data()['studio'].length; i++) {
      mListCardStudio.add(
        CardBarHachtge(
          caty: mCategories.data()['studio'][i].toString(),
          isStudio: true,
          onTap: () {},
        ),
      );
    }
  }

  Color _colorLike = Colors.white; //Default white color
  Future<bool> checkIfMovieLiked() async {
    if (await Func.checkMovieIsInFavorites(id: widget.idMovie)) {
      setState(() {
        _colorLike = kColorRed01;
      });
      return true;
    } else {
      setState(() {
        _colorLike = Theme.of(context).primaryColorDark;
      });
      return false;
    }
  }

  Future<void> checkIfSubscribed() async {
    final _isSubscribe =
        await Subscribe.checkMovieSubscribe(idMovie: widget.idMovie);
    setState(() {
      isSubscribe = _isSubscribe;
    });
  }

  @override
  void initState() {
    getDataMovie();
    checkIfMovieLiked();
    checkIfSubscribed();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    final TextDirection currentDirection = Directionality.of(context);

    ///Size Layout
    final mSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: themeChange.darkTheme ? kColorBlack02 : Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title:
                  CardVisible(isVisible: name.isNotEmpty, child: Text('$name')),
              centerTitle: true,
              pinned: true,
              // floating: true,
              leading: IconButton(
                icon: Icon(
                  currentDirection == TextDirection.rtl
                      ? FontAwesomeIcons.chevronRight
                      : FontAwesomeIcons.chevronLeft,
                  color: kColorRed01,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    FontAwesomeIcons.solidHeart,
                    color: _colorLike,
                  ),
                  onPressed: () async {
                    //Delete movie
                    if (await checkIfMovieLiked()) {
                      Func.deleteMovieFromFavorite(
                        id: widget.idMovie,
                      );
                      showTopSnackBare(
                          context: context,
                          isInfo: true,
                          message:
                              '$name ${getTranslationText(context, 'delete_from_favorite')}');
                    } else {
                      //Save Movie
                      Func.saveMovieToFavorite(
                        Movies(
                          id: widget.idMovie,
                          image: image,
                          name: name,
                          summary: summary,
                        ),
                      );
                      showTopSnackBare(
                          context: context,
                          isSuccess: true,
                          message:
                              '$name ${getTranslationText(context, 'add_to_favorite')}');
                    }
                    //setNew Changes
                    checkIfMovieLiked();
                  },
                )
              ],
              expandedHeight: (mSize.height / 2) + 40,
              flexibleSpace: CardActionBarMovies(
                isMovie: isMovie,
                isThemDark: themeChange.darkTheme,
                idDocument: widget.idMovie,
                image: image,
                date: date,
                time: time,
                episode: sizeEpisodes,
                status: status,
                listCategories: mListCardCategories,
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 15.0),
                      kActiveNotification
                          ? Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: kColorRed01,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 15.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: RichText(
                                      overflow: TextOverflow.ellipsis,
                                      text: TextSpan(children: [
                                        TextSpan(
                                          text: getTranslationText(
                                              context, 'subscribe_to'),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        TextSpan(
                                          text: ' $name',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ]),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      if (isSubscribe) {
                                        final _unsubscribe =
                                            await Subscribe.unSubscribeToMovie(
                                          idMovie: widget.idMovie,
                                          context: context,
                                        );

                                        if (_unsubscribe)
                                          showTopSnackBare(
                                              context: context,
                                              isInfo: _unsubscribe,
                                              message:
                                                  '${getTranslationText(context, 'unsubscribe_to')} $name');
                                      } else {
                                        final _subscribe =
                                            await Subscribe.subscribeToMovie(
                                          idMovie: widget.idMovie,
                                          context: context,
                                        );
                                        if (_subscribe)
                                          showTopSnackBare(
                                              context: context,
                                              isSuccess: _subscribe,
                                              message:
                                                  '${getTranslationText(context, 'subscribe_to')} $name');
                                      }
                                      checkIfSubscribed();
                                    },
                                    icon: Icon(
                                      isSubscribe
                                          ? FontAwesomeIcons.solidBell
                                          : FontAwesomeIcons.bell,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : SizedBox(),
                      Container(
                        decoration: BoxDecoration(
                          color: kColorRed01,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        margin: EdgeInsets.symmetric(vertical: 15.0),
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AnimatedSize(
                              vsync: this,
                              duration: Duration(seconds: 1),
                              curve: Curves.fastOutSlowIn,
                              child: Container(
                                // height: 80.0,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      getTranslationText(context, 'summary'),
                                      style: kStyleTitle01.copyWith(
                                          color: Colors.white, fontSize: 15.0),
                                    ),
                                    CardVisible(
                                      isVisible: summary != '',
                                      child: ReadMoreText(
                                        summary,
                                        trimLines: 2,
                                        colorClickableText: Colors.white,
                                        trimMode: TrimMode.Line,
                                        trimCollapsedText:
                                            '...${getTranslationText(context, 'show_more')}',
                                        trimExpandedText:
                                            ' ${getTranslationText(context, 'show_less')}',
                                        style: kStyleTitle01.copyWith(
                                            color: Colors.white,
                                            fontSize: 12.0,
                                            height: 1.3),
                                      ),
                                    ),
                                    _cardInfo
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(height: 5.0),
                                              Text(
                                                getTranslationText(
                                                    context, 'movie_info'),
                                                style: kStyleTitle01.copyWith(
                                                    color: Colors.white,
                                                    fontSize: 15.0),
                                              ),
                                              CardVisible(
                                                isVisible: status != '',
                                                child: CardRowInfoMovie(
                                                  label:
                                                      '${getTranslationText(context, 'status')}:',
                                                  body: status,
                                                ),
                                              ),
                                              CardVisible(
                                                isVisible: format != '',
                                                child: CardRowInfoMovie(
                                                  label: getTranslationText(
                                                      context, 'format'),
                                                  body: format,
                                                ),
                                              ),
                                              CardVisible(
                                                isVisible: season != '',
                                                child: CardRowInfoMovie(
                                                  label: getTranslationText(
                                                      context, 'season'),
                                                  body: season,
                                                ),
                                              ),
                                              CardVisible(
                                                isVisible: source != '',
                                                child: CardRowInfoMovie(
                                                  label: getTranslationText(
                                                      context, 'source'),
                                                  body: source,
                                                ),
                                              ),
                                              CardVisible(
                                                isVisible: !isMovie,
                                                child: CardVisible(
                                                  isVisible: sizeEpisodes != '',
                                                  child: CardRowInfoMovie(
                                                    label: getTranslationText(
                                                        context,
                                                        'total_episode'),
                                                    body: sizeEpisodes,
                                                  ),
                                                ),
                                              ),
                                              CardVisible(
                                                isVisible: firstAired != '',
                                                child: CardRowInfoMovie(
                                                  label: getTranslationText(
                                                      context, 'first_aired'),
                                                  body: firstAired,
                                                ),
                                              ),
                                              SizedBox(height: 5.0),
                                              CardVisible(
                                                isVisible:
                                                    mListCardStudio != [],
                                                child: Text(
                                                  getTranslationText(
                                                      context, 'studio'),
                                                  style: kStyleTitle01.copyWith(
                                                      color: Colors.white,
                                                      fontSize: 15.0),
                                                ),
                                              ),
                                              CardVisible(
                                                isVisible:
                                                    mListCardStudio != [],
                                                child: Wrap(
                                                  runSpacing: 5.0,
                                                  spacing: 5.0,
                                                  children: mListCardStudio,
                                                ),
                                              ),
                                              SizedBox(height: 10.0),
                                              Text(
                                                getTranslationText(
                                                    context, 'character'),
                                                style: kStyleTitle01.copyWith(
                                                    color: Colors.white,
                                                    fontSize: 15.0),
                                              ),
                                              FutureBuilder(
                                                  future:
                                                      Database.getArrayMovie(
                                                          document:
                                                              widget.idMovie),
                                                  builder: (context, snapshot) {
                                                    if (!snapshot.hasData) {
                                                      return ProgressCircle();
                                                    }

                                                    try {
                                                      final mCharacters =
                                                          snapshot.data[
                                                              'characters'];

                                                      List<CardImageCharacter>
                                                          mListCardImageCharacter =
                                                          [];

                                                      for (var character
                                                          in mCharacters) {
                                                        mListCardImageCharacter
                                                            .add(
                                                          CardImageCharacter(
                                                            onTap: () {
                                                              print("click");
                                                            },
                                                            image: character[
                                                                'image'],
                                                            name: character[
                                                                    'name'] ??
                                                                '',
                                                          ),
                                                        );
                                                      }

                                                      return CardVisible(
                                                        isVisible:
                                                            mListCardImageCharacter !=
                                                                [],
                                                        child: SizedBox(
                                                          width: mSize.width,
                                                          height: 115.0,
                                                          child: ListView(
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            children:
                                                                mListCardImageCharacter,
                                                          ),
                                                        ),
                                                      );
                                                    } catch (e) {
                                                      print('Error: $e');
                                                    }
                                                    return SizedBox();
                                                  }),
                                              SizedBox(height: 15.0),
                                            ],
                                          )
                                        : SizedBox(),
                                  ],
                                ),
                              ),
                            ),
                            Center(
                              child: CardBarHachtge(
                                caty: !_cardInfo
                                    ? getTranslationText(context, 'show_more')
                                    : getTranslationText(context, 'show_less'),
                                isStudio: true,
                                onTap: () {
                                  setState(() {
                                    _cardInfo = !_cardInfo;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: kColorRed01,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              getTranslationText(context, 'trailer'),
                              style: kStyleTitle01.copyWith(
                                  color: Colors.white, fontSize: 15.0),
                            ),
                            SizedBox(height: 5.0),
                            FutureBuilder(
                                future: Database.getArrayMovie(
                                    document: widget.idMovie),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return ProgressCircle();
                                  }

                                  try {
                                    final mTrailers = snapshot.data['trailers'];

                                    List<CardImageTrailer>
                                        mListCardImageTrailer = [];

                                    for (var trailer in mTrailers) {
                                      mListCardImageTrailer.add(
                                        CardImageTrailer(
                                          keyImage: trailer['link'],
                                          onTap: () async {
                                            await launch(
                                                'https://www.youtube.com/watch?v=${trailer['link']}');
                                          },
                                        ),
                                      );
                                    }

                                    return SizedBox(
                                      width: mSize.width,
                                      height: 75.0,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        children: mListCardImageTrailer,
                                      ),
                                    );
                                  } catch (e) {
                                    print('Error: $e');
                                  }
                                  return SizedBox();
                                }),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
                CardVisible(
                  isVisible: arrayCategories.isNotEmpty,
                  child: StreamBuilder<QuerySnapshot>(
                      stream: Database.getRecommendedPosts(
                          categories: arrayCategories),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return SizedBox(
                            height: 70.0,
                          );
                        }

                        final mRecom = snapshot.data.docs;

                        if (mRecom.isEmpty) {
                          return SizedBox(
                            height: 70.0,
                          );
                        }

                        List<CardListMovie> mListCardListMovie = [];

                        for (var rec in mRecom) {
                          //don't display the same movie in list recommend
                          if (widget.idMovie != rec.id) {
                            mListCardListMovie.add(
                              CardListMovie(
                                image: rec.data()['image'],
                                title: rec.data()['name'] ?? '',
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ContentMovieScreen(
                                        idMovie: rec.id,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          }
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextTitle(
                              label: getTranslationText(context, 'recommend'),
                            ),
                            SizedBox(height: 15.0),
                            SizedBox(
                              width: double.infinity,
                              height: 170.0,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                padding: EdgeInsets.symmetric(horizontal: 5.0),
                                children: mListCardListMovie,
                              ),
                            ),
                          ],
                        );
                      }),
                ),
                SizedBox(height: 300.0),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

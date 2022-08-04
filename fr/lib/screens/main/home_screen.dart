import 'package:azul_movies/constants.dart';
import 'package:azul_movies/models/database.dart';
import 'package:azul_movies/screens/all_categories/sheet_calendar_movies.dart';
import 'package:azul_movies/screens/content/content_movie_screen.dart';
import 'package:azul_movies/widgets/widgets_home.dart';
import 'package:azul_movies/widgets/widgets_main.dart';
import 'package:azul_movies/widgets/widgets_toolbar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:azul_movies/screens/all_categories/all_movies_screen.dart';
import '../search_screen.dart';
import 'favorite_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int episodeIndex = 0;
  int topMovieIndex = 0;

  static var dateNow = DateTime.now(); //Default date today
  String _timeMapSelected;
  bool oldPosts = false;

  var selectedType = 'movie'; //Default Movie

  @override
  void initState() {
    _timeMapSelected = DateFormat("dd-MM-yyyy").format(dateNow);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 70.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///Carousel
                    StreamBuilder<QuerySnapshot>(
                      stream: Database.getAllPosts(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: CircularProgressIndicator());
                        }

                        final mPosts = snapshot.data.docs;
                        List<CardCarouselHome> mListCardCarouselHome = [];

                        for (var posts in mPosts) {
                          mListCardCarouselHome.add(
                            CardCarouselHome(
                              image: posts.data()['image'],
                              title: '${posts.data()['name']}',
                              isMovie: posts.data()['type'] == 'movie',
                              idMovie: posts.id,
                            ),
                          );
                        }

                        return CarouselSlider(
                          items: mListCardCarouselHome,
                          options: CarouselOptions(
                            height: 180.0,
                            // autoPlay: true,
                            autoPlayAnimationDuration: Duration(seconds: 2),
                            autoPlayInterval: Duration(seconds: 5),
                            autoPlayCurve: Curves.ease,
                            pauseAutoPlayOnTouch: true,
                            enableInfiniteScroll: true,
                            enlargeCenterPage: true,
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextTitle(
                      label: getTranslationText(context, 'new_episode'),
                    ),
                    SizedBox(height: 10.0),
                    Center(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CardTabRed(
                                width: 20.0,
                                label: getTranslationText(context, 'today'),
                                isSelected: episodeIndex == 0,
                                onTap: () {
                                  setState(() {
                                    episodeIndex = 0;
                                    oldPosts = false;
                                    _timeMapSelected =
                                        DateFormat("dd-MM-yyyy HH:mm")
                                            .format(dateNow);
                                  });
                                },
                              ),
                              CardTabRed(
                                width: 10.0,
                                label: getTranslationText(context, 'yesterday'),
                                isSelected: episodeIndex == 1,
                                onTap: () {
                                  setState(() {
                                    episodeIndex = 1;
                                    oldPosts = false;
                                    _timeMapSelected = DateFormat("dd-MM-yyyy")
                                        .format(yesterdayDate(dateNow));
                                  });
                                },
                              ),
                              CardTabRed(
                                width: 15.0,
                                label:
                                    getTranslationText(context, '2_days_ago'),
                                isSelected: episodeIndex == 2,
                                onTap: () {
                                  setState(() {
                                    episodeIndex = 2;
                                    oldPosts = true;
                                    //i'm setting her HH:mm to get the first to last movies...
                                    _timeMapSelected =
                                        DateFormat("dd-MM-yyyy HH:mm")
                                            .format(twoDaysAgoDate(dateNow));
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15.0),

                    //Posts Date Selected
                    StreamBuilder<QuerySnapshot>(
                        stream: Database.getPostsDate(
                          timeMap: _timeMapSelected,
                          oldPosts: oldPosts,
                        ),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(child: CircularProgressIndicator());
                          }
                          final mPosts = snapshot.data.docs;

                          if (mPosts.isEmpty) {
                            return Center(child: Text('...'));
                          }

                          List<CardListMovie> mListCardListMovie = [];
                          for (var post in mPosts) {
                            mListCardListMovie.add(
                              CardListMovie(
                                image: post.data()['image'],
                                title: post.data()['name'],
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ContentMovieScreen(
                                        idMovie: post.id,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          }

                          if (mListCardListMovie.isNotEmpty) {
                            mListCardListMovie.add(
                              CardListMovie(
                                title: '',
                                image: kImageAllMovies,
                                onTap: () {
                                  // all movies
                                  showBarModalBottomSheet(
                                    context: context,
                                    builder: (context) => SheetCalendarMovies(),
                                  );
                                },
                              ),
                            );
                          }

                          return CardListItems(
                            children: mListCardListMovie,
                          );
                        }),
                    SizedBox(height: 20.0),
                    TextTitle(
                      label: getTranslationText(context, 'editors_chooses'),
                    ),
                    SizedBox(height: 10.0),
                    //Editor
                    StreamBuilder<QuerySnapshot>(
                        stream: Database.getEditorPosts(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(child: CircularProgressIndicator());
                          }

                          final mPosts = snapshot.data.docs;
                          List<CardMoviesDisplay> mListCardListMovie = [];

                          for (var post in mPosts) {
                            mListCardListMovie.add(
                              CardMoviesDisplay(
                                isDirectionLTR: !isLayoutRTL(context),
                                image: post.data()['image'],
                                title: post.data()['name'],
                                body: post.data()['summary'],
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ContentMovieScreen(
                                        idMovie: post.data()['id_movie'],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          }

                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Column(
                              children: mListCardListMovie,
                            ),
                          );
                        }),

                    SizedBox(height: 25.0),
                    Center(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CardTabRed(
                                width: 20.0,
                                label: getTranslationText(context, 'movies'),
                                isSelected: topMovieIndex == 0,
                                onTap: () {
                                  setState(() {
                                    topMovieIndex = 0;
                                    selectedType = 'movie';
                                  });
                                },
                              ),
                              CardTabRed(
                                width: 5.0,
                                label: getTranslationText(context, 'series'),
                                isSelected: topMovieIndex == 1,
                                onTap: () {
                                  setState(() {
                                    topMovieIndex = 1;
                                    selectedType = 'serie';
                                  });
                                },
                              ),
                              CardTabRed(
                                width: 10.0,
                                label: getTranslationText(context, 'shows'),
                                isSelected: topMovieIndex == 2,
                                onTap: () {
                                  setState(() {
                                    topMovieIndex = 2;
                                    selectedType = 'show';
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15.0),
                    StreamBuilder<QuerySnapshot>(
                        stream: Database.getTypePosts(type: selectedType),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(child: CircularProgressIndicator());
                          }

                          final mType = snapshot.data.docs;

                          if (mType.isEmpty) {
                            return Center(child: Text('Empty...'));
                          }

                          List<CardListMovie> mListCardListMovie = [];

                          for (var movie in mType) {
                            mListCardListMovie.add(
                              CardListMovie(
                                image: movie.data()['image'],
                                title: movie.data()['name'],
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ContentMovieScreen(
                                        idMovie: movie.id,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          }

                          if (mListCardListMovie.isNotEmpty) {
                            mListCardListMovie.add(
                              CardListMovie(
                                title: '',
                                image: kImageAllMovies,
                                onTap: () {
                                  // all types => selectedType
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AllMoviesScreen(
                                        typeMovies: selectedType,
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
                  ],
                ),
              ),
            ),
            CardAppBarBlack(
              label: kAppName,
              onCalendar: () {
                // Calendar
                showBarModalBottomSheet(
                  context: context,
                  builder: (context) => SheetCalendarMovies(),
                );
              },
              onSearch: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

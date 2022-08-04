import 'package:azul_movies/models/database.dart';
import 'package:azul_movies/widgets/widgets_browse.dart';
import 'package:azul_movies/widgets/widgets_toolbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import 'all_movies_screen.dart';

class AllCategories extends StatefulWidget {
  @override
  _AllCategoriesState createState() => _AllCategoriesState();
}

class _AllCategoriesState extends State<AllCategories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 60.0),
              child: StreamBuilder<QuerySnapshot>(
                  stream: Database.getCategories(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return LinearProgressIndicator();
                    }

                    final mCategories = snapshot.data.docs;
                    List<CardRawCaty> mListCardRawCaty = [];

                    for (var caty in mCategories) {
                      mListCardRawCaty.add(
                        CardRawCaty(
                          image: caty.data()['image'],
                          title: caty.data()['title'],
                          onTap: () {
                            // SHow All Movies
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AllMoviesScreen(
                                  category: caty.data()['title'],
                                  isCategory: true,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }

                    return GridView(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      physics: BouncingScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 10.0,
                        childAspectRatio: 2.0,
                      ),
                      children: mListCardRawCaty,
                    );
                  }),
            ),
            CardAppBarRed(
              title: getTranslationText(context, 'all_caty'),
              hasBack: true,
            ),
          ],
        ),
      ),
    );
  }
}

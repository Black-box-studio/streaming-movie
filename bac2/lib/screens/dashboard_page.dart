import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:panel_back_end/constants.dart';
import 'package:panel_back_end/models/databse.dart';
import 'package:panel_back_end/widgets/cards_dashboard.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  var _movies = 'wait...';
  var _series = 'wait...';
  var _shows = 'wait...';
  var _categories = 'wait...';
  var _studios = 'wait...';

  Future<void> getSizeData() async {
    final mSizeMovies = await Database.getSizedMovies(key: 'movie');
    final mSizeSeries = await Database.getSizedMovies(key: 'serie');
    final mSizeShows = await Database.getSizedMovies(key: 'show');
    final mSizeCategories =
        await Database.getSizedCategoriesAndStudio(key: 'Categories');
    final mSizeStudios =
        await Database.getSizedCategoriesAndStudio(key: 'Studios');

    setState(() {
      _movies = mSizeMovies.toString() ?? '0';
      _series = mSizeSeries.toString() ?? '0';
      _shows = mSizeShows.toString() ?? '0';
      _categories = mSizeCategories.toString() ?? '0';
      _studios = mSizeStudios.toString() ?? '0';
    });
  }

  @override
  void initState() {
    getSizeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mSize = MediaQuery.of(context).size;
    return Container(
      width: mSize.width,
      height: mSize.height,
      padding: EdgeInsets.all(25.0),
      child: SingleChildScrollView(
        child: Wrap(
          spacing: 20.0,
          runSpacing: 20.0,
          children: [
            CardDashboardSize(
              icon: FontAwesomeIcons.tv,
              label: 'Size Movies',
              body: _movies,
              gradient: kGradient01,
            ),
            CardDashboardSize(
              icon: FontAwesomeIcons.film,
              label: 'Size Series',
              body: _series,
              gradient: kGradient02,
            ),
            CardDashboardSize(
              icon: FontAwesomeIcons.magic,
              label: 'Size Shows',
              body: _shows,
              gradient: kGradient03,
            ),
            CardDashboardSize(
              icon: FontAwesomeIcons.stream,
              label: 'Size Categories',
              body:  _categories,
              gradient: kGradient04,
            ),
            CardDashboardSize(
              icon: FontAwesomeIcons.studiovinari,
              label: 'Size Studios',
              body: _studios,
              gradient: kGradient06,
            ),
            /*  CardDashboardEditorSize(
              gradient: kGradient05,
            ),*/
          ],
        ),
      ),
    );
  }
}

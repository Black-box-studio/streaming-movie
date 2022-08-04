import 'package:azul_movies/constants.dart';
import 'package:azul_movies/screens/content/content_movie_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DialogNotification extends StatelessWidget {
  final title;
  final body;
  final image;
  final idMovie;

  DialogNotification({
    @required this.title,
    @required this.body,
    @required this.image,
    @required this.idMovie,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        '$title',
        style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColorDark),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
      titlePadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
      content: Container(
        height: 300.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: CachedNetworkImage(
                imageUrl: image,
                fit: BoxFit.cover,
                placeholder: (context, widget) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                '$body',
                maxLines: 3,
                style: TextStyle(
                    fontSize: 12.0, color: Theme.of(context).primaryColorDark),
              ),
            ),
          ],
        ),
      ),
      actions: [
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          // color: kColorRed01.withOpacity(0.26),
          textColor: Theme.of(context).primaryColorDark.withOpacity(0.26),
          child: Text('later'),
        ),
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ContentMovieScreen(idMovie: idMovie),
                ));
          },
          color: kColorRed01,
          textColor: Colors.white,
          child: Text('watch'),
        ),
      ],
    );
  }
}

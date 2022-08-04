import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CardPickedLanguage extends StatelessWidget {
  final name, flag;

  CardPickedLanguage({@required this.name, @required this.flag});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Flag('$flag', height: 35.0, width: 35.0),
        Text(flag),
        SizedBox(width: 10.0),
        Text(
          '$name',
          style: TextStyle(
            fontSize: 12.0,
          ),
        ),
        SizedBox(width: 10.0),
        Padding(
          padding: EdgeInsets.only(bottom: 10.0),
          child: Icon(
            FontAwesomeIcons.sortDown,
            size: 18.0,
          ),
        ),
      ],
    );
  }
}

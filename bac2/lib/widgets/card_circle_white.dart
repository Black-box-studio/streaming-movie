import 'package:flutter/material.dart';
import 'package:panel_back_end/constants.dart';

class CardCircle extends StatelessWidget {
  final IconData icon;

  CardCircle(this.icon);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: Opacity(
            opacity: 0.119999997317791,
            child: Container(
              width: 123,
              height: 123,
              decoration: BoxDecoration(
                color: Color(0xffffffff),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Opacity(
            opacity: 0.15000000596046448,
            child: Container(
              width: 111,
              height: 111,
              decoration: new BoxDecoration(
                color: Color(0xffffffff),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            width: 97,
            height: 97,
            decoration: BoxDecoration(
              color: Color(0xffffffff),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(icon, color: kColorBlack03),
            ),
          ),
        ),
      ],
    );
  }
}

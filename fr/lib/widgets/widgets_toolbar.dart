import 'package:azul_movies/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CardAppBarRed extends StatelessWidget {
  final title;
  final bool hasBack;
  final bool hasActionRight;
  final onClick;

  CardAppBarRed({
    @required this.title,
    this.hasBack = false,
    this.hasActionRight = false,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    final TextDirection currentDirection = Directionality.of(context);
    return Material(
      color: kColorRed01,
      borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(20.0),
        bottomLeft: Radius.circular(20.0),
      ),
      elevation: 5.0,
      child: Container(
        width: double.infinity,
        height: 55.0,
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            hasBack
                ? IconButton(
                    icon: Icon(
                      currentDirection == TextDirection.ltr
                          ? FontAwesomeIcons.chevronLeft
                          : FontAwesomeIcons.chevronRight,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                : SizedBox(width: 40.0),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            hasActionRight
                ? IconButton(
                    icon: Icon(
                      FontAwesomeIcons.sort,
                      color: Colors.white,
                    ),
                    onPressed: onClick,
                  )
                : SizedBox(width: 40.0),
          ],
        ),
      ),
    );
  }
}

class CardAppBarBlack extends StatelessWidget {
  final label;
  final onSearch;
  final onCalendar;

  CardAppBarBlack(
      {@required this.label,
      @required this.onSearch,
      @required this.onCalendar});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(20.0),
        bottomLeft: Radius.circular(20.0),
      ),
      elevation: 5.0,
      child: Container(
        width: double.infinity,
        height: 55.0,
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          children: [
            SizedBox(width: 10.0),
            Text(
              label,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(),
            IconButton(
              icon: Icon(
                FontAwesomeIcons.calendarDay,
                size: 18.0,
              ),
              onPressed: onCalendar,
            ),
            IconButton(
              icon: Icon(
                FontAwesomeIcons.search,
                size: 18.0,
              ),
              onPressed: onSearch,
            ),
          ],
        ),
      ),
    );
  }
}

class CardAppBarListGrid extends StatelessWidget {
  final title;
  final bool hasBack;
  final bool isList;
  final onClick;

  CardAppBarListGrid({
    @required this.title,
    this.hasBack = false,
    this.isList = true,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    final TextDirection currentDirection = Directionality.of(context);
    return Material(
      color: kColorRed01,
      borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(20.0),
        bottomLeft: Radius.circular(20.0),
      ),
      elevation: 5.0,
      child: Container(
        width: double.infinity,
        height: 55.0,
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            hasBack
                ? IconButton(
                    icon: Icon(
                      currentDirection == TextDirection.ltr
                          ? FontAwesomeIcons.chevronLeft
                          : FontAwesomeIcons.chevronRight,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                : SizedBox(width: 40.0),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            Switch(
              value: isList,
              onChanged: onClick,
              // activeColor: kColorRed01,
              //inactiveThumbColor: Colors.black,
              activeTrackColor: Colors.white,
              inactiveTrackColor: Colors.white,
              activeThumbImage: AssetImage('assets/images/list_solid.png'),
              inactiveThumbImage: AssetImage('assets/images/grid_solid.png'),
            ),
            /* IconButton(
              icon: Icon(
                isList ? FontAwesomeIcons.list : FontAwesomeIcons.th,
                color: Colors.white,
              ),
              onPressed: onClick,
            ),*/
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants.dart';

class CardBottomNav extends StatelessWidget {
  final list;

  CardBottomNav({
    @required this.list,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 55.0,
      decoration: BoxDecoration(
        // color: Colors.red,
        color: Theme.of(context).primaryColor,
        boxShadow: [kBoxShadow01],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: list,
      ),
    );
  }
}

class CardTabNav extends StatelessWidget {
  final bool isSelected;
  final icon;
  final label;
  final Function onPress;

  CardTabNav({
    @required this.isSelected,
    @required this.icon,
    @required this.label,
    @required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 600),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
        decoration: BoxDecoration(
          color:
              isSelected ? kColorRed01.withOpacity(0.26) : Colors.transparent,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: isSelected
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    color: kColorRed01,
                    size: 20.0,
                  ),
                  SizedBox(width: 5.0),
                  Text(
                    label,
                    style: TextStyle(fontSize: 17.0, color: kColorRed01),
                  ),
                ],
              )
            : Icon(
                icon,
                color: kColorBlack04,
              ),
      ),
    );
  }
}

class CardPickDarkLightMode extends StatelessWidget {
  final label;
  final isSelected;
  final Function onPress;

  CardPickDarkLightMode({
    this.label,
    this.isSelected,
    @required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: 50.0,
        height: 30.0,
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : kColorRed01,
          border: Border.all(color: kColorRed01, width: 1.0),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? kColorRed01 : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class CardPickListOrGrid extends StatelessWidget {
  final label;
  final bool isSelected;
  final Function onPress;

  CardPickListOrGrid({
    this.label,
    this.isSelected,
    @required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: 50.0,
        height: 30.0,
        decoration: BoxDecoration(
          color: !isSelected ? Colors.white : kColorRed01,
          border: Border.all(color: kColorRed01, width: 1.0),
        ),
        child: Center(
          child: SizedBox(
            height: 26.0,
            child: Icon(
              label == 'List'
                  ? FontAwesomeIcons.list
                  : FontAwesomeIcons.borderAll,
              size: 18.0,
              color: isSelected ? Colors.white : kColorRed01,
            ),
          ),
        ),
      ),
    );
  }
}

class TextTitle extends StatelessWidget {
  final label;

  TextTitle({@required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Text(
        label,
        style: kStyleTitle01.copyWith(fontSize: 15.0),
      ),
    );
  }
}

class CardTabRed extends StatelessWidget {
  final label;
  final width;
  final onTap;
  final isSelected;

  CardTabRed({
    @required this.label,
    @required this.width,
    @required this.onTap,
    @required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: width,
              height: 3.0,
              decoration: BoxDecoration(
                  color: isSelected ? kColorRed01 : Colors.transparent,
                  borderRadius: BorderRadius.circular(50.0)),
            ),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? kColorRed01 : kColorBlack04,
                fontSize: 16.0,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardPadding extends StatelessWidget {
  final child;

  final horizontal, vertical;

  CardPadding(
      {@required this.child, this.horizontal = 10.0, this.vertical = 0.0});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
      child: child,
    );
  }
}

class CardListItems extends StatelessWidget {
  final children;

  CardListItems({
    @required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 180.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 5.0),
        children: children,
      ),
    );
  }
}

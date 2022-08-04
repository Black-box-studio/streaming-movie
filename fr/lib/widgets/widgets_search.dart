import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants.dart';

class InputSearch extends StatelessWidget {
  final mSize;
  final hint;
  final Function value;

  InputSearch({
    @required this.mSize,
    @required this.hint,
    @required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: mSize.width,
      height: 45.0,
      margin: EdgeInsets.only(
          left: isLayoutRTL(context) ? 50.0 : 0,
          right: isLayoutRTL(context) ? 0 : 50.0),
      decoration: BoxDecoration(
        color: kColorRed01,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(isLayoutRTL(context) ? 0.0 : 30.0),
          topRight: Radius.circular(isLayoutRTL(context) ? 0.0 : 30.0),
          bottomLeft: Radius.circular(isLayoutRTL(context) ? 30.0 : 0),
          topLeft: Radius.circular(isLayoutRTL(context) ? 30.0 : 0),
        ),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
          // isDense: false,
          contentPadding: EdgeInsets.only(top: 7.0, left: 10.0, right: 10.0),
          hintStyle: TextStyle(
            color: Colors.white54,
            fontSize: 15.0,
          ),
          suffixIcon: Icon(
            FontAwesomeIcons.search,
            size: 18.0,
            color: Colors.white,
          ),
        ),
        minLines: 1,
        cursorColor: kColorGrey01,
        onChanged: value,
        style: TextStyle(color: Colors.white, fontSize: 15.0),
      ),
    );
  }
}

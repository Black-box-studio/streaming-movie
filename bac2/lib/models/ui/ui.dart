import 'package:flutter/cupertino.dart';

class Character {
  final String image;
  final String name;

  Character({
    @required this.image,
    @required this.name,
  });
}

class Categories {
  final String title;
  final String image;
  bool selected;

  Categories({
    @required this.title,
    @required this.image,
    @required this.selected,
  });
}

class Studios {
  final String title;
  // final String image;
  bool selected;

  Studios({
    @required this.title,
    // @required this.image,
    @required this.selected,
  });
}

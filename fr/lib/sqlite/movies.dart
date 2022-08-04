/// ClientModel.dart
import 'dart:convert';

import 'package:flutter/cupertino.dart';

Movies moviesFromJson(String str) {
  final jsonData = json.decode(str);
  return Movies.fromMap(jsonData);
}

String clientToJson(Movies data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Movies {
  String id;
  String name;
  String image;
  String summary;

  Movies(
      {@required this.id,
      @required this.name,
      @required this.image,
      @required this.summary});

  factory Movies.fromMap(Map<String, dynamic> json) => new Movies(
        id: json["id"],
        name: json["name"],
        summary: json["summary"],
        image: json["image"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "summary": summary,
        "image": image,
      };
}

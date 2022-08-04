/*
// To parse this JSON data, do
//
//     final movies = moviesFromJson(jsonString);

import 'dart:convert';

Movies moviesFromJson(String str) => Movies.fromJson(json.decode(str));

String moviesToJson(Movies data) => json.encode(data.toJson());

class Movies {
  Movies({
    this.name,
    this.summary,
    this.date,
    this.firstAired,
    this.status,
    this.time,
    this.season,
    this.format,
    this.source,
    this.image,
    this.timeMap,
    this.categories,
    this.characters,
    this.studio,
    this.trailers,
    this.type,
  });

  final String name;
  final String summary;
  final String date;
  final String firstAired;
  final String status;
  final String time;
  final String season;
  final String format;
  final String source;
  final String image;
  final String timeMap;
  final List<String> categories;
  final List<Character> characters;
  final List<String> studio;
  final List<Trailer> trailers;
  final String type;

  factory Movies.fromJson(Map<String, dynamic> json) => Movies(
        name: json["name"],
        summary: json["summary"],
        date: json["date"],
        firstAired: json["firstAired"],
        status: json["status"],
        time: json["time"],
        season: json["season"],
        format: json["format"],
        source: json["source"],
        image: json["image"],
        timeMap: json["timeMap"],
        categories: List<String>.from(json["categories"].map((x) => x)),
        characters: List<Character>.from(
            json["characters"].map((x) => Character.fromJson(x))),
        studio: List<String>.from(json["studio"].map((x) => x)),
        trailers: List<Trailer>.from(
            json["trailers"].map((x) => Trailer.fromJson(x))),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "summary": summary,
        "date": date,
        "firstAired": firstAired,
        "status": status,
        "time": time,
        "season": season,
        "format": format,
        "source": source,
        "image": image,
        "timeMap": timeMap,
        "categories": List<dynamic>.from(categories.map((x) => x)),
        "characters": List<dynamic>.from(characters.map((x) => x.toJson())),
        "studio": List<dynamic>.from(studio.map((x) => x)),
        "trailers": List<dynamic>.from(trailers.map((x) => x.toJson())),
        "type": type,
      };
}

class Character {
  Character({
    this.image,
    this.name,
  });

  final String image;
  final String name;

  factory Character.fromJson(Map<String, dynamic> json) => Character(
        image: json["image"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "name": name,
      };
}

class Trailer {
  Trailer({
    this.image,
    this.link,
  });

  final String image;
  final String link;

  factory Trailer.fromJson(Map<String, dynamic> json) => Trailer(
        image: json["image"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "link": link,
      };
}
*/

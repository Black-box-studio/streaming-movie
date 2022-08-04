import 'dart:io';
import 'package:azul_movies/sqlite/movies.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "FavMovies.db");

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute(
        "CREATE TABLE Movies ("
        "id TEXT,"
        "name TEXT,"
        "image TEXT,"
        "summary TEXT"
        ")",
      );
    });
  }

  ///CREATE Movie
  newMovie(Movies newMovie) async {
    final db = await database;
    var res = await db.insert("Movies", newMovie.toMap());
    return res;
  }

  ///GET Movie ID
  getMovie(String id) async {
    final db = await database;
    var res = await db.query(
      "Movies",
      where: "id = ?",
      whereArgs: [id],
    );
    return res.isNotEmpty ? Movies.fromMap(res.first) : Null;
  }

  ///GET ALL Movies
  Future<List<Movies>> getAllMovies() async {
    final db = await database;
    var res = await db.query("Movies");
    List<Movies> list =
        res.isNotEmpty ? res.map((c) => Movies.fromMap(c)).toList() : [];
    return list;
  }

  ///UPDATE Movie ID
  updateMovie(Movies newMovie) async {
    final db = await database;
    var res = await db.update(
      "Movies",
      newMovie.toMap(),
      where: "id = ?",
      whereArgs: [newMovie.id],
    );
    return res;
  }

  ///DELETE Movie ID
  deleteMovie(String id) async {
    final db = await database;
    db.delete(
      "Movies",
      where: "id = ?",
      whereArgs: [id],
    );
  }

  ///DELETE ALL Movies
  deleteAllMovies() async {
    final db = await database;
    db.rawDelete("Delete * from Movies");
  }
}

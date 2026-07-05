import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'saved_movie.dart';

class SavedMovieService {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    String path = join(
      await getDatabasesPath(),
      'movies.db',
    );

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE saved_movies(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          posterUrl TEXT
        )
        ''');
      },
    );

    return _database!;
  }

  Future<void> addMovie(
      SavedMovie movie) async {
    final db = await database;

    await db.insert(
      'saved_movies',
      movie.toMap(),
    );
  }

  Future<void> removeMovie(
      String title) async {
    final db = await database;

    await db.delete(
      'saved_movies',
      where: 'title = ?',
      whereArgs: [title],
    );
  }

  Future<List<SavedMovie>>
  getAllSavedMovies() async {
    final db = await database;

    final data =
    await db.query('saved_movies');

    return data
        .map((e) => SavedMovie.fromMap(e))
        .toList();
  }

  Future<bool> isSaved(
      String title) async {
    final db = await database;

    final data = await db.query(
      'saved_movies',
      where: 'title = ?',
      whereArgs: [title],
    );

    return data.isNotEmpty;
  }
}
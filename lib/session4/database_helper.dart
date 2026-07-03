import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseConstants {
  static const String databaseName = 'my_music_app.db';
  static const int databaseVersion = 2;

  static const String playlistsTable = 'playlists';

  static const String createPlaylistsTable = '''
    CREATE TABLE playlists(
      id INTEGER PRIMARY KEY,
      name TEXT NOT NULL,
      songCount INTEGER NOT NULL
    )
  ''';
}

class DatabaseHelper {
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance =
  DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initializeDatabase();
    return _database!;
  }

  Future<Database> _initializeDatabase() async {
    String dbPath = await getDatabasesPath();

    String path = join(
      dbPath,
      DatabaseConstants.databaseName,
    );

    return await openDatabase(
      path,
      version: DatabaseConstants.databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(
      Database db,
      int version,
      ) async {
    await db.execute(
      DatabaseConstants.createPlaylistsTable,
    );
  }

  Future<void> _onUpgrade(
      Database db,
      int oldVersion,
      int newVersion,
      ) async {
    if (oldVersion < 2) {
      await db.execute('''
        ALTER TABLE playlists
        ADD COLUMN coverImage TEXT
        ''',
      );
    }
  }
}
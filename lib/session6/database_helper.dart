import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'restaurant_model.dart';

class DatabaseHelper {
  DatabaseHelper._();

  static final DatabaseHelper instance =
  DatabaseHelper._();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(
      await getDatabasesPath(),
      'restaurants.db',
    );

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE restaurants(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          cuisine TEXT NOT NULL
        )
        ''');
      },
    );
  }

  Future<int> insertRestaurant(
      Restaurant restaurant) async {
    final db = await database;

    return await db.insert(
      'restaurants',
      restaurant.toMap(),
    );
  }

  Future<List<Restaurant>>
  getRestaurants() async {
    final db = await database;

    final result =
    await db.query('restaurants');

    return result
        .map(
          (e) => Restaurant.fromMap(e),
    )
        .toList();
  }

  Future<int> updateRestaurant(
      Restaurant restaurant) async {
    final db = await database;

    return await db.update(
      'restaurants',
      restaurant.toMap(),
      where: 'id = ?',
      whereArgs: [restaurant.id],
    );
  }

  Future<int> deleteRestaurant(
      int id) async {
    final db = await database;

    return await db.delete(
      'restaurants',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
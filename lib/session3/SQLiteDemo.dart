import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SQLiteDemo extends StatefulWidget {
  @override
  State<SQLiteDemo> createState() => _SQLiteDemoState();
}

class _SQLiteDemoState extends State<SQLiteDemo> {
  Database? database;
  List<Map<String, dynamic>> restaurants = [];

  @override
  void initState() {
    super.initState();
    initializeDatabase();
  }

  Future<void> initializeDatabase() async {
    String path = join(await getDatabasesPath(), 'zomato.db');

    database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE Restaurants(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          location TEXT NOT NULL,
          rating REAL NOT NULL
        )
        ''');
      },
    );

    await insertSampleData();
    await fetchRestaurants();
  }

  Future<void> insertSampleData() async {
    await database!.insert(
      'Restaurants',
      {
        'name': 'Dominos',
        'location': 'Rajkot',
        'rating': 4.5,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    await database!.insert(
      'Restaurants',
      {
        'name': 'McDonalds',
        'location': 'Ahmedabad',
        'rating': 4.3,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> fetchRestaurants() async {
    final data = await database!.query('Restaurants');

    setState(() {
      restaurants = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SQLite Restaurant Demo'),
      ),
      body: ListView.builder(
        itemCount: restaurants.length,
        itemBuilder: (context, index) {
          final restaurant = restaurants[index];

          return ListTile(
            leading: CircleAvatar(
              child: Text(restaurant['id'].toString()),
            ),
            title: Text(restaurant['name']),
            subtitle: Text(restaurant['location']),
            trailing: Text(
              restaurant['rating'].toString(),
            ),
          );
        },
      ),
    );
  }
}
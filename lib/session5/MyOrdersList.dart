import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MyOrdersList extends StatefulWidget {
  const MyOrdersList({super.key});

  @override
  State<MyOrdersList> createState() =>
      _MyOrdersListState();
}

class _MyOrdersListState
    extends State<MyOrdersList> {
  Database? database;
  List<String> orders = [];

  @override
  void initState() {
    super.initState();
    initializeDatabase();
  }

  Future<void> initializeDatabase() async {
    String path = join(
      await getDatabasesPath(),
      'orders.db',
    );

    database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE orders(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT
        )
        ''');
      },
    );

    await loadOrders();
  }

  Future<void> loadOrders() async {
    final result =
    await database!.query('orders');

    setState(() {
      orders = result
          .map((e) => e['name'].toString())
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      AppBar(title: const Text('My Orders')),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(orders[index]),
          );
        },
      ),
    );
  }
}
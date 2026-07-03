import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MyOrdersList2 extends StatefulWidget {
  const MyOrdersList2({super.key});

  @override
  State<MyOrdersList2> createState() =>
      _MyOrdersList2State();
}

class _MyOrdersList2State
    extends State<MyOrdersList2> {
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

    orders = await fetchOrdersAsync();

    setState(() {});
  }

  Future<List<String>> fetchOrdersAsync() async {
    final result =
    await database!.query('orders');

    return result
        .map((e) => e['name'].toString())
        .toList();
  }

  Future<void> addOrder(
      String orderName) async {
    await database!.insert(
      'orders',
      {
        'name': orderName,
      },
    );

    orders = await fetchOrdersAsync();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      AppBar(title: const Text('Orders')),
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
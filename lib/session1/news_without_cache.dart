import 'package:flutter/material.dart';

class NewsWithoutCache extends StatelessWidget {
  NewsWithoutCache({super.key});

  final List<String> headlines = [
    "India wins cricket match",
    "Flutter 4.0 Released",
    "AI Revolution in 2026",
    "Stock Market Updates",
    "SpaceX Launch Successful"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("News Feed"),
      ),
      body: ListView.builder(
        itemCount: headlines.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(headlines[index]),
          );
        },
      ),
    );
  }
}
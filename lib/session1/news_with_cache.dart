import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewsWithCache extends StatefulWidget {
  const NewsWithCache({super.key});

  @override
  State<NewsWithCache> createState() => _NewsWithCacheState();
}

class _NewsWithCacheState extends State<NewsWithCache> {
  List<String> headlines = [];

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    List<String> mockApiData = [
      "India wins cricket match",
      "Flutter 4.0 Released",
      "AI Revolution in 2026",
      "Stock Market Updates",
      "SpaceX Launch Successful"
    ];

    headlines = mockApiData;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      'cached_news',
      jsonEncode(mockApiData),
    );

    setState(() {});
  }

  Future<void> loadCachedNews() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? data = prefs.getString('cached_news');

    if (data != null) {
      headlines = List<String>.from(jsonDecode(data));

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("News Feed Cached"),
        actions: [
          IconButton(
            icon: const Icon(Icons.cloud_off),
            onPressed: loadCachedNews,
          )
        ],
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
import 'package:flutter/material.dart';

class RestaurantListScreen extends StatefulWidget {
  const RestaurantListScreen({super.key});

  @override
  State<RestaurantListScreen> createState() =>
      _RestaurantListScreenState();
}

class _RestaurantListScreenState
    extends State<RestaurantListScreen> {
  bool isLoading = true;
  bool hasError = false;

  String errorMessage = '';

  List<String> restaurants = [];

  @override
  void initState() {
    super.initState();
    fetchRestaurants();
  }

  Future<void> fetchRestaurants() async {
    setState(() {
      isLoading = true;
      hasError = false;
    });

    try {
      await Future.delayed(
        const Duration(seconds: 2),
      );

      restaurants = [
        "Domino's Pizza",
        "McDonald's",
        "KFC",
        "Subway",
        "Burger King",
      ];

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        hasError = true;
        errorMessage = e.toString();
      });
    }
  }

  Widget buildBody() {
    /// Loading State
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (hasError) {
      return Center(
        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 80,
            ),
            const SizedBox(height: 10),
            Text(errorMessage),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: fetchRestaurants,
              child: const Text("Retry"),
            ),
          ],
        ),
      );
    }

    if (restaurants.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.favorite_border,
              size: 100,
            ),
            const SizedBox(height: 15),
            const Text(
              "No items yet!",
              style: TextStyle(
                fontSize: 22,
                fontWeight:
                FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Start adding products you love.",
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: fetchRestaurants,
      child: ListView.builder(
        itemCount: restaurants.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading:
            const Icon(Icons.restaurant),
            title:
            Text(restaurants[index]),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Capstone Session 2",
        ),
      ),
      body: buildBody(),
    );
  }
}
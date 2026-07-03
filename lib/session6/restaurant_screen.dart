import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'restaurant_model.dart';

class RestaurantScreen extends StatefulWidget {
  const RestaurantScreen({super.key});

  @override
  State<RestaurantScreen> createState() =>
      _RestaurantScreenState();
}

class _RestaurantScreenState
    extends State<RestaurantScreen> {
  List<Restaurant> restaurants = [];

  @override
  void initState() {
    super.initState();
    loadRestaurants();
  }

  Future<void> loadRestaurants() async {
    restaurants =
    await DatabaseHelper.instance
        .getRestaurants();

    setState(() {});
  }

  Future<void> addDummyData() async {
    await DatabaseHelper.instance
        .insertRestaurant(
      Restaurant(
        name: "Dominos",
        cuisine: "Pizza",
      ),
    );

    await loadRestaurants();
  }

  Future<void> deleteRestaurant(
      Restaurant restaurant) async {
    await DatabaseHelper.instance
        .deleteRestaurant(
      restaurant.id!,
    );

    await loadRestaurants();

    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(
          "${restaurant.name} deleted",
        ),
        action: SnackBarAction(
          label: "UNDO",
          onPressed: () async {
            await DatabaseHelper.instance
                .insertRestaurant(
              Restaurant(
                name: restaurant.name,
                cuisine:
                restaurant.cuisine,
              ),
            );

            await loadRestaurants();
          },
        ),
      ),
    );
  }

  void showEditDialog(
      Restaurant restaurant) {
    final nameController =
    TextEditingController(
      text: restaurant.name,
    );

    final cuisineController =
    TextEditingController(
      text: restaurant.cuisine,
    );

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text(
              "Edit Restaurant"),
          content: Column(
            mainAxisSize:
            MainAxisSize.min,
            children: [
              TextField(
                controller:
                nameController,
                decoration:
                const InputDecoration(
                  labelText: "Name",
                ),
              ),
              TextField(
                controller:
                cuisineController,
                decoration:
                const InputDecoration(
                  labelText:
                  "Cuisine",
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                    context);
              },
              child:
              const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                restaurant.name =
                    nameController.text;

                restaurant.cuisine =
                    cuisineController.text;

                await DatabaseHelper
                    .instance
                    .updateRestaurant(
                    restaurant);

                Navigator.pop(
                    context);

                await loadRestaurants();
              },
              child:
              const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(
      BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Restaurants",
        ),
      ),
      floatingActionButton:
      FloatingActionButton(
        onPressed: addDummyData,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: restaurants.length,
        itemBuilder:
            (context, index) {
          final restaurant =
          restaurants[index];

          return Dismissible(
            key: Key(
              restaurant.id
                  .toString(),
            ),
            direction:
            DismissDirection
                .endToStart,
            background:
            Container(
              color: Colors.red,
              alignment:
              Alignment
                  .centerRight,
              padding:
              const EdgeInsets
                  .only(
                right: 20,
              ),
              child: const Icon(
                Icons.delete,
                color:
                Colors.white,
              ),
            ),
            onDismissed: (_) {
              deleteRestaurant(
                  restaurant);
            },
            child: Card(
              margin:
              const EdgeInsets
                  .all(8),
              child: ListTile(
                title: Text(
                  restaurant.name,
                ),
                subtitle: Text(
                  restaurant
                      .cuisine,
                ),
                trailing:
                IconButton(
                  icon: const Icon(
                    Icons.edit,
                  ),
                  onPressed: () {
                    showEditDialog(
                        restaurant);
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
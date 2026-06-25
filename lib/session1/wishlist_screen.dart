import 'package:flutter/material.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final List<String> wishlist = [];

  final List<String> products = [
    "iPhone 15",
    "Samsung Galaxy S24",
    "Boat Headphones",
    "Nike Shoes",
    "Laptop Bag"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flipkart Wishlist"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                String product = products[index];

                return ListTile(
                  title: Text(product),
                  trailing: IconButton(
                    icon: Icon(
                      wishlist.contains(product)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      setState(() {
                        if (wishlist.contains(product)) {
                          wishlist.remove(product);
                        } else {
                          wishlist.add(product);
                        }
                      });
                    },
                  ),
                );
              },
            ),
          ),
          const Divider(),
          const Text(
            "Wishlist",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: wishlist.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(wishlist[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
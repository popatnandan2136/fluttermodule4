import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() =>
      _ProductScreenState();
}

class _ProductScreenState
    extends State<ProductScreen> {
  bool isLoading = true;

  List<String> products = [];

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  Future<void> loadProducts() async {
    await Future.delayed(
      const Duration(seconds: 2),
    );

    products = [
      "iPhone 16",
      "Samsung S26",
      "MacBook Air",
      "AirPods Pro"
    ];

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(
      BuildContext context) {
    return Scaffold(
      appBar:
      AppBar(title: const Text("Products")),
      body: isLoading
          ? const Center(
        child:
        CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount:
        products.length,
        itemBuilder:
            (context, index) {
          return ListTile(
            title: Text(
                products[index]),
          );
        },
      ),
    );
  }
}
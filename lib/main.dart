import 'package:flutter/material.dart';
import 'package:module4/session1/dark_mode_screen.dart';
import 'package:module4/session1/news_with_cache.dart';
import 'package:module4/session1/news_without_cache.dart';
import 'package:module4/session1/wishlist_screen.dart';

void main() {
  runApp(const MyApp());
  // runApp(const DarkModeScreen());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      // Session1
            home: WishlistScreen(),
            // home: NewsWithoutCache(),
            // home: NewsWithCache(),

      // Session2
            // home: FutureBuilder(
            //   future: checkLogin(),
            //   builder: (context, snapshot) {
            //
            //     if (!snapshot.hasData) {
            //       return const Scaffold(
            //         body: Center(
            //           child: CircularProgressIndicator(),
            //         ),
            //       );
            //     }
            //
            //     return snapshot.data!
            //         ? const HomeScreen()
            //         : const LoginScreen();
            //   },
            // ),

      // Session3

    );
  }
}
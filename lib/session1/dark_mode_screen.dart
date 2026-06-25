import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DarkModeScreen extends StatefulWidget {
  const DarkModeScreen({super.key});

  @override
  State<DarkModeScreen> createState() => _DarkModeScreenState();
}

class _DarkModeScreenState extends State<DarkModeScreen> {
  bool isDark = false;

  @override
  void initState() {
    super.initState();
    loadTheme();
  }

  Future<void> loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      isDark = prefs.getBool('darkMode') ?? false;
    });
  }

  Future<void> saveTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkMode', value);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDark ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Instagram Dark Mode"),
        ),
        body: Center(
          child: SwitchListTile(
            title: const Text("Dark Mode"),
            value: isDark,
            onChanged: (value) {
              setState(() {
                isDark = value;
              });

              saveTheme(value);
            },
          ),
        ),
      ),
    );
  }
}
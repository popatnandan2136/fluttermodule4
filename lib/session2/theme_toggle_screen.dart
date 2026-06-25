import 'package:flutter/material.dart';
import 'theme_service.dart';

class ThemeToggleScreen extends StatefulWidget {
  const ThemeToggleScreen({super.key});

  @override
  State<ThemeToggleScreen> createState() =>
      _ThemeToggleScreenState();
}

class _ThemeToggleScreenState
    extends State<ThemeToggleScreen> {

  bool isDark = false;

  @override
  void initState() {
    super.initState();
    loadTheme();
  }

  Future<void> loadTheme() async {
    isDark = await ThemeService.getThemePreference();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: isDark
          ? ThemeData.dark()
          : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Dark Mode"),
        ),
        body: Center(
          child: SwitchListTile(
            title: const Text("Dark Mode"),
            value: isDark,
            onChanged: (value) async {

              setState(() {
                isDark = value;
              });

              await ThemeService
                  .saveThemePreference(value);
            },
          ),
        ),
      ),
    );
  }
}
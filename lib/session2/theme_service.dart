import 'package:shared_preferences/shared_preferences.dart';

class ThemeService {

  static Future<void> saveThemePreference(bool isDarkMode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkMode', isDarkMode);
  }

  static Future<bool> getThemePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('darkMode') ?? false;
  }

}
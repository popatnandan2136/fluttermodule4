class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._();

  DatabaseHelper._();

  List<String> _products = [
    "iPhone 16",
    "Samsung Galaxy S26",
    "MacBook Air M5",
    "AirPods Pro"
  ];

  Map<String, dynamic> _userProfile = {
    "name": "Nandan",
    "points": 1000,
  };

  Future<List<String>> fetchProducts() async {
    try {
      await Future.delayed(const Duration(seconds: 2));

      print("Products Loaded Successfully");
      print(_products);

      return _products;
    } catch (e) {
      print("Database Error: $e");
      return [];
    }
  }

  Future<Map<String, dynamic>> fetchUserProfile() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _userProfile;
  }

  Future<int> getPoints() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _userProfile["points"];
  }

  Future<void> savePoints(int points) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _userProfile["points"] = points;
  }
}
class Restaurant {
  int? id;
  String name;
  String cuisine;

  Restaurant({
    this.id,
    required this.name,
    required this.cuisine,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'cuisine': cuisine,
    };
  }

  factory Restaurant.fromMap(
      Map<String, dynamic> map) {
    return Restaurant(
      id: map['id'],
      name: map['name'],
      cuisine: map['cuisine'],
    );
  }
}
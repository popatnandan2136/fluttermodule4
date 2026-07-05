class SavedMovie {
  int? id;
  String title;
  String posterUrl;

  SavedMovie({
    this.id,
    required this.title,
    required this.posterUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'posterUrl': posterUrl,
    };
  }

  factory SavedMovie.fromMap(
      Map<String, dynamic> map) {
    return SavedMovie(
      id: map['id'],
      title: map['title'],
      posterUrl: map['posterUrl'],
    );
  }
}
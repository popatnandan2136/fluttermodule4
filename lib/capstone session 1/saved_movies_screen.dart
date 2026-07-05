import 'package:flutter/material.dart';

import 'saved_movie.dart';
import 'saved_movie_service.dart';

class SavedMoviesScreen
    extends StatefulWidget {
  const SavedMoviesScreen({
    super.key,
  });

  @override
  State<SavedMoviesScreen>
  createState() =>
      _SavedMoviesScreenState();
}

class _SavedMoviesScreenState
    extends State<SavedMoviesScreen> {
  final SavedMovieService service =
  SavedMovieService();

  List<SavedMovie> movies = [];

  @override
  void initState() {
    super.initState();
    loadMovies();
  }

  Future<void> loadMovies() async {
    final data =
    await service.getAllSavedMovies();

    setState(() {
      movies = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
        const Text("Saved Movies"),
      ),
      body: movies.isEmpty
          ? const Center(
        child: Text(
          "No Saved Movies",
        ),
      )
          : ListView.builder(
        itemCount: movies.length,
        itemBuilder:
            (context, index) {
          return ListTile(
            leading:
            Image.network(
              movies[index]
                  .posterUrl,
              width: 50,
            ),
            title: Text(
              movies[index]
                  .title,
            ),
          );
        },
      ),
    );
  }
}
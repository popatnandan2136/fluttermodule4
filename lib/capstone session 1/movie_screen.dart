import 'package:flutter/material.dart';

import 'saved_movie.dart';
import 'saved_movie_service.dart';
import 'saved_movies_screen.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key});

  @override
  State<MovieScreen> createState() =>
      _MovieScreenState();
}

class _MovieScreenState
    extends State<MovieScreen> {
  final SavedMovieService service =
  SavedMovieService();

  final List<Map<String, String>> movies = [
    {
      "title": "Avengers",
      "poster":
      "https://picsum.photos/200?1"
    },
    {
      "title": "Batman",
      "poster":
      "https://picsum.photos/200?2"
    },
    {
      "title": "Joker",
      "poster":
      "https://picsum.photos/200?3"
    },
    {
      "title": "Interstellar",
      "poster":
      "https://picsum.photos/200?4"
    },
    {
      "title": "Titanic",
      "poster":
      "https://picsum.photos/200?5"
    },
  ];

  List<String> savedTitles = [];

  @override
  void initState() {
    super.initState();
    loadSavedMovies();
  }

  Future<void> loadSavedMovies() async {
    final data =
    await service.getAllSavedMovies();

    setState(() {
      savedTitles =
          data.map((e) => e.title).toList();
    });
  }

  Future<void> toggleFavorite(
      Map<String, String> movie) async {
    if (savedTitles
        .contains(movie['title'])) {
      await service.removeMovie(
          movie['title']!);
    } else {
      await service.addMovie(
        SavedMovie(
          title: movie['title']!,
          posterUrl: movie['poster']!,
        ),
      );
    }

    await loadSavedMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movies"),
        actions: [
          IconButton(
            icon: const Icon(
                Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                  const SavedMoviesScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];

          return ListTile(
            leading: Image.network(
              movie['poster']!,
              width: 50,
            ),
            title:
            Text(movie['title']!),
            trailing: IconButton(
              icon: Icon(
                savedTitles.contains(
                    movie['title'])
                    ? Icons.favorite
                    : Icons
                    .favorite_border,
              ),
              onPressed: () =>
                  toggleFavorite(movie),
            ),
          );
        },
      ),
    );
  }
}
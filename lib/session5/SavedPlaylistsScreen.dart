import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SavedPlaylistsScreen extends StatefulWidget {
  const SavedPlaylistsScreen({super.key});

  @override
  State<SavedPlaylistsScreen> createState() =>
      _SavedPlaylistsScreenState();
}

class _SavedPlaylistsScreenState
    extends State<SavedPlaylistsScreen> {
  final TextEditingController playlistController =
  TextEditingController();

  Database? database;
  List<Map<String, dynamic>> playlists = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    initializeDatabase();
  }

  Future<void> initializeDatabase() async {
    String path = join(
      await getDatabasesPath(),
      'music_app.db',
    );

    database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE playlists(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT
          )
        ''');
      },
    );

    await fetchPlaylists();
  }

  Future<void> insertPlaylist() async {
    if (playlistController.text.trim().isEmpty) return;

    setState(() {
      isLoading = true;
    });

    await database!.insert(
      'playlists',
      {
        'name': playlistController.text.trim(),
      },
    );

    playlistController.clear();

    await fetchPlaylists();

    setState(() {
      isLoading = false;
    });
  }

  Future<void> fetchPlaylists() async {
    final data = await database!.query('playlists');

    setState(() {
      playlists = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Playlists'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: playlistController,
              decoration: const InputDecoration(
                labelText: 'Playlist Name',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: isLoading
                  ? null
                  : insertPlaylist,
              child: const Text('Add Playlist'),
            ),

            const SizedBox(height: 20),

            if (isLoading)
              const CircularProgressIndicator(),

            Expanded(
              child: ListView.builder(
                itemCount: playlists.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      playlists[index]['name'],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
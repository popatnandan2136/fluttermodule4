import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RememberMeScreen extends StatefulWidget {
  const RememberMeScreen({super.key});

  @override
  State<RememberMeScreen> createState() =>
      _RememberMeScreenState();
}

class _RememberMeScreenState
    extends State<RememberMeScreen> {

  final TextEditingController usernameController =
  TextEditingController();

  bool rememberMe = false;

  @override
  void initState() {
    super.initState();
    loadSavedUsername();
  }

  Future<void> loadSavedUsername() async {

    SharedPreferences prefs =
    await SharedPreferences.getInstance();

    String username =
        prefs.getString('username') ?? '';

    if (username.isNotEmpty) {
      usernameController.text = username;
      rememberMe = true;
    }

    setState(() {});
  }

  Future<void> login() async {

    SharedPreferences prefs =
    await SharedPreferences.getInstance();

    if (rememberMe) {
      await prefs.setString(
        'username',
        usernameController.text,
      );
    } else {
      await prefs.remove('username');
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Login Successful"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Remember Me"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: "Username",
              ),
            ),

            CheckboxListTile(
              title: const Text("Remember Me"),
              value: rememberMe,
              onChanged: (value) {
                setState(() {
                  rememberMe = value!;
                });
              },
            ),

            ElevatedButton(
              onPressed: login,
              child: const Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'auth_service.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await AuthService.login();
          },
          child: const Text("Login"),
        ),
      ),
    );
  }
}
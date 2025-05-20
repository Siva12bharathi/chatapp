import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mynotesapp/Screens/profile_screen.dart';

import 'package:mynotesapp/services/login_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginService = LoginService();
  bool isLoading = false;

  void _handleLogin(BuildContext context) async {
    setState(() => isLoading = true);

    final user = await loginService.signInWithGoogle();

    if (!mounted) return;

    setState(() => isLoading = false);

    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => ProfileScreen(user: user)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Login failed or canceled.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Google Login")),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator() // ⏳ Show loader during login
            : ElevatedButton.icon(
          icon: const Icon(Icons.login),
          label: const Text("Sign in with Google"),
          onPressed: () => _handleLogin(context),
        ),
      ),
    );
  }
}

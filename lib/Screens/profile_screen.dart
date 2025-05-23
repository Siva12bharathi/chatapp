import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mynotesapp/Screens/chat_screen.dart';
import '../models/user_model.dart';
import '../services/login_service.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  final loginService = LoginService();

  ProfileScreen({super.key});

  void _logout(BuildContext context) async {
    await loginService.signOut();
    final box = Hive.box<HiveUser>('userBox');
    await box.delete('currentUser');

    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<HiveUser>('userBox');
    final user = box.get('currentUser');

    if (user == null) {
      return const Scaffold(
        body: Center(child: Text("No user found")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Profile"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(user.photoUrl),
              radius: 50,
            ),
            const SizedBox(height: 16),
            Text(user.name),
            Text(user.email),
            const SizedBox(height: 100),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatScreen()),
                );
              },
              icon: const Icon(Icons.chat),
            )
          ],
        ),
      ),
    );
  }
}

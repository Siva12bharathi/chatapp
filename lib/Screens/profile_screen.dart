import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mynotesapp/Screens/chat_screen.dart';
import '../services/login_service.dart';
import 'login_screen.dart';



class ProfileScreen extends StatelessWidget {
  final User user;
  final loginService = LoginService();

  ProfileScreen({super.key, required this.user});

  void _logout(BuildContext context) async {
    await loginService.signOut();
    if (context.mounted) {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      if (context.mounted) {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen())); // Or go to login screen
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
              backgroundImage: NetworkImage(user.photoURL ?? ""),
              radius: 50,
            ),
            const SizedBox(height: 16),
            Text(user.displayName ?? "No name"),
            Text(user.email ?? "No email"),

            SizedBox(
              height: 100,
            ),

            IconButton(onPressed: (){

              Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatScreen()));

            }, icon: Icon(Icons.chat))
          ],
        ),
      ),
    );
  }
}

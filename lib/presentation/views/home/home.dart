import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Make sure if a user is not logged in and somehow lands on /home, you redirect them back:
  @override
  void initState() {
    super.initState();

    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      // Delayed to avoid navigation errors on build
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, '/auth');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // SIGNOUT FUNCTION
    Future<void> signOutUser(BuildContext context) async {
      await FirebaseAuth.instance.signOut();

      // Go back to Auth or Splash screen
      Navigator.pushNamedAndRemoveUntil(
          context, '/splash-screen', (route) => false);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
              onPressed: () {
                signOutUser(context);
              },
              icon: Icon(Icons.logout_rounded)),
        ],
      ),
    );
  }
}

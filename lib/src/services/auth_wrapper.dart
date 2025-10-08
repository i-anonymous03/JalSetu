import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jalsetu/src/screens/auth/login_page.dart';
import 'package:jalsetu/src/screens/home_screen.dart';

// This widget acts as a gatekeeper. It listens for authentication changes
// and shows the correct screen based on whether a user is logged in.
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // While waiting for the connection, show a loading indicator
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        // If the snapshot has data, it means the user is logged in.
        if (snapshot.hasData) {
          return const HomeScreen();
        }
        // Otherwise, the user is not logged in.
        else {
          return const LoginPage();
        }
      },
    );
  }
}


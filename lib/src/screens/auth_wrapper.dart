import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jalsetu/src/providers/auth_provider.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, _) {
        // Show loading indicator while checking auth state
        if (authProvider.isLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final user = authProvider.user;
        
        // Use Future.microtask to avoid calling Navigator during build
        Future.microtask(() {
          if (user == null) {
            Navigator.pushReplacementNamed(context, '/welcome');
          } else {
            Navigator.pushReplacementNamed(context, authProvider.getHomeRoute());
          }
        });

        // Return a loading screen while navigation is being handled
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
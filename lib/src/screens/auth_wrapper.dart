import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jalsetu/src/providers/auth_provider.dart';
import 'package:jalsetu/src/screens/welcome_screen.dart';
import 'package:jalsetu/routes.dart';
import 'package:jalsetu/src/screens/home_screen.dart';
import 'package:jalsetu/src/screens/volunteer_dashboard.dart';
import 'package:jalsetu/src/screens/clinic_dashboard.dart';


/// This widget is the gatekeeper of the app. It listens to the authentication state
/// and declaratively builds the correct screen. This is more performant than
/// navigating imperatively in a build method.
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, _) {
        // While the provider is initializing and checking the auth state,
        // show a loading screen.
        if (authProvider.isLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final user = authProvider.user;

        // If there is no user, show the WelcomeScreen.
        if (user == null) {
          return const WelcomeScreen();
        } else {
          // If there is a user, determine their role and show the correct dashboard.
          final homeRoute = authProvider.getHomeRoute();
          switch (homeRoute) {
            case AppRoutes.home:
              return const HomeScreen();
            case AppRoutes.volunteerDashboard:
              return const VolunteerDashboard();
            case AppRoutes.clinicDashboard:
              return const ClinicDashboard();
            default:
              // As a fallback, if the role is unknown, show the welcome screen.
              return const WelcomeScreen();
          }
        }
      },
    );
  }
}

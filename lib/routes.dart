import 'package:flutter/material.dart';
import 'package:jalsetu/src/services/auth_wrapper.dart'; // <--- Import AuthWrapper
import 'package:jalsetu/src/screens/auth/login_page.dart';
import 'package:jalsetu/src/screens/auth/register_page.dart';
import 'package:jalsetu/src/screens/auth/phone_auth_page.dart';
import 'package:jalsetu/src/screens/home_screen.dart';
import 'package:jalsetu/src/screens/alerts_screen.dart';
import 'package:jalsetu/src/screens/feedback_screen.dart';
import 'package:jalsetu/src/screens/health_screen.dart';
import 'package:jalsetu/src/screens/help_screen.dart';
import 'package:jalsetu/src/screens/symptom_report_screen.dart';

class AppRoutes {
  // Define a constant for the root route name
  static const String root = '/'; 
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String phoneAuth = '/phoneAuth';
  static const String alerts = '/alerts';
  static const String health = '/health';
  static const String feedback = '/feedback';
  static const String help = '/help';
  static const String reportSymptom = '/report-symptom';

  static final Map<String, WidgetBuilder> routes = {
    // --- ADDED: This makes the AuthWrapper the root of the app ---
    root: (context) => const AuthWrapper(),

    // All other named routes
    login: (context) => const LoginPage(),
    register: (context) => const RegisterPage(),
    home: (context) => const HomeScreen(),
    phoneAuth: (context) => const PhoneAuthPage(),
    alerts: (context) => const AlertsScreen(),
    health: (context) => const HealthScreen(),
    feedback: (context) => const FeedbackScreen(),
    help: (context) => const HelpScreen(),
    reportSymptom: (context) => const SymptomReportScreen(),
  };
}

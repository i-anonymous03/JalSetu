import 'package:flutter/material.dart';
import 'package:jalsetu/src/screens/home_screen.dart';
import 'package:jalsetu/src/screens/welcome_screen.dart';
import 'package:jalsetu/src/screens/role_selection_screen.dart';
import 'package:jalsetu/src/screens/login_screen.dart';
import 'package:jalsetu/src/screens/registration_screen.dart';
import 'package:jalsetu/src/screens/alerts_screen.dart';
import 'package:jalsetu/src/screens/feedback_screen.dart';
import 'package:jalsetu/src/screens/health_screen.dart';
import 'package:jalsetu/src/screens/help_screen.dart';
import 'package:jalsetu/src/screens/symptom_report_screen.dart';
import 'package:jalsetu/src/screens/volunteer_dashboard.dart';
import 'package:jalsetu/src/screens/clinic_dashboard.dart';

class AppRoutes {
  // Define a constant for the root route name
  static const String root = '/';
  static const String welcome = '/welcome';
  static const String roleSelect = '/role-select';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String alerts = '/alerts';
  static const String health = '/health';
  static const String feedback = '/feedback';
  static const String help = '/help';
  static const String reportSymptom = '/report-symptom';
  static const String volunteerDashboard = '/volunteer-dashboard';
  static const String clinicDashboard = '/clinic-dashboard';

  static final Map<String, WidgetBuilder> routes = {
    root: (context) => const WelcomeScreen(),
    welcome: (context) => const WelcomeScreen(),
    roleSelect: (context) {
      final args = ModalRoute.of(context)!.settings.arguments as String;
      return RoleSelectionScreen(flowType: args);
    },
    login: (context) {
      final args = ModalRoute.of(context)!.settings.arguments as String;
      return LoginScreen(role: args);
    },
    register: (context) {
      final args = ModalRoute.of(context)!.settings.arguments as String;
      return RegistrationScreen(role: args);
    },
    home: (context) => const HomeScreen(),
    alerts: (context) => const AlertsScreen(),
    health: (context) => const HealthScreen(),
    feedback: (context) => const FeedbackScreen(),
    help: (context) => const HelpScreen(),
    reportSymptom: (context) => const SymptomReportScreen(),
    volunteerDashboard: (context) => const VolunteerDashboard(),
    clinicDashboard: (context) => const ClinicDashboard(),
  };
}

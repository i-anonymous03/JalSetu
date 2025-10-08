import 'package:flutter/material.dart';
import 'package:jalsetu/src/models/alert.dart';
import 'package:jalsetu/src/widgets/alert_card.dart';
import 'package:jalsetu/src/widgets/bottom_nav.dart';

class AlertsScreen extends StatelessWidget {
  const AlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Alert> alerts = [
      Alert(
          title: 'High Turbidity Detected',
          description: 'Turbidity level has exceeded the safe limit.',
          timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
          isCritical: true),
      Alert(
          title: 'Low pH Level',
          description: 'pH level is lower than the recommended range.',
          timestamp: DateTime.now().subtract(const Duration(hours: 2)),
          isCritical: true),
      Alert(
          title: 'Maintenance Reminder',
          description: 'Filter replacement is due next week.',
          timestamp: DateTime.now().subtract(const Duration(days: 1)),
          isCritical: false),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Alerts'),
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        itemCount: alerts.length,
        itemBuilder: (context, index) {
          return AlertCard(alert: alerts[index]);
        },
      ),
      bottomNavigationBar: const BottomNav(currentIndex: 1),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:jalsetu/src/models/alert.dart';
import 'package:intl/intl.dart';

class AlertCard extends StatelessWidget {
  final Alert alert;

  const AlertCard({super.key, required this.alert});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: alert.isCritical ? Colors.red[100] : Colors.white,
      child: ListTile(
        leading: Icon(
          alert.isCritical ? Icons.error : Icons.info,
          color: alert.isCritical ? Colors.red : Colors.blue,
        ),
        title: Text(alert.title),
        subtitle: Text(alert.description),
        trailing: Text(DateFormat('hh:mm a').format(alert.timestamp)),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:jalsetu/routes.dart';
import 'package:jalsetu/src/widgets/bottom_nav.dart';
import 'package:jalsetu/src/widgets/sensor_tile.dart';
import 'package:jalsetu/src/widgets/language_selector.dart';
import 'package:jalsetu/generated/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.dashboardTitle),
        automaticallyImplyLeading: false,
        actions: const [
          LanguageSelector(),
          SizedBox(width: 8), // Add some padding on the right
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16.0),
        children: const [
          SensorTile(sensorName: 'pH Level', value: '7.2', status: 'Normal'),
          SensorTile(
              sensorName: 'Turbidity', value: '5 NTU', status: 'Normal'),
          SensorTile(
              sensorName: 'TDS', value: '150 ppm', status: 'Excellent'),
          SensorTile(
              sensorName: 'Temperature', value: '25°C', status: 'Normal'),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.reportSymptom);
        },
        label: Text(AppLocalizations.of(context)!.reportSymptomsButton),
        icon: const Icon(Icons.medical_services),
        backgroundColor: Colors.redAccent,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: const BottomNav(currentIndex: 0),
    );
  }
}
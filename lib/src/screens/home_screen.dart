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
    bool isGuest = true; // TODO: Replace with actual auth check
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          children: [
            FutureBuilder(
              future: precacheImage(const AssetImage('assets/images/jalsetu_logo.png'), context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Image.asset(
                    'assets/images/jalsetu_logo.png',
                    height: 32,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.water_drop, color: Colors.white),
                  );
                } else {
                  return const Icon(Icons.water_drop, color: Colors.white);
                }
              },
            ),
            const SizedBox(width: 12),
            Text(
              AppLocalizations.of(context)?.dashboardTitle ?? 'JalSetu',
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
        actions: const [
          LanguageSelector(),
          SizedBox(width: 8),
        ],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(16.0),
              children: const [
                SensorTile(sensorName: 'pH Level', value: '7.2', status: 'Normal'),
                SensorTile(sensorName: 'Turbidity', value: '5 NTU', status: 'Normal'),
                SensorTile(sensorName: 'TDS', value: '150 ppm', status: 'Excellent'),
                SensorTile(sensorName: 'Temperature', value: '25°C', status: 'Normal'),
              ],
            ),
          ),
          if (isGuest) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Column(
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.person_outline),
                    label: Text(AppLocalizations.of(context)?.roleVillager ?? 'Continue as Guest'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    onPressed: () {
                      // TODO: Implement guest dashboard logic
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Continuing as Guest...')),
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/role-selection', arguments: 'login');
                    },
                    child: Text(AppLocalizations.of(context)?.signInButton ?? 'Login'),
                  ),
                ],
              ),
            ),
          ],
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
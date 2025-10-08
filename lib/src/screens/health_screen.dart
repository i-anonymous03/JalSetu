import 'package:flutter/material.dart';
import 'package:jalsetu/src/widgets/bottom_nav.dart';

class HealthScreen extends StatelessWidget {
  const HealthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Water Health Report'),
        automaticallyImplyLeading: false,
      ),
      body: const Center(
        child: Text('Detailed water health analysis will be shown here.'),
      ),
      bottomNavigationBar: const BottomNav(currentIndex: 2),
    );
  }
}
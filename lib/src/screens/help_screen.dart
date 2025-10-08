import 'package:flutter/material.dart';
import 'package:jalsetu/src/widgets/bottom_nav.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support'),
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        children: const [
          ListTile(
            leading: Icon(Icons.help_outline),
            title: Text('FAQs'),
            subtitle: Text('Frequently Asked Questions'),
          ),
          ListTile(
            leading: Icon(Icons.contact_phone),
            title: Text('Contact Us'),
            subtitle: Text('Get in touch with our support team'),
          ),
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('About Us'),
            subtitle: Text('Learn more about JalSetu'),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNav(currentIndex: 4),
    );
  }
}
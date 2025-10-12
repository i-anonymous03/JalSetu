import 'package:flutter/material.dart';
import 'package:jalsetu/generated/app_localizations.dart';
import 'package:jalsetu/src/widgets/language_selector.dart';

class RoleSelectionScreen extends StatelessWidget {
  final String flowType; // 'login' or 'register'

  const RoleSelectionScreen({super.key, required this.flowType});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    void navigateToAuthScreen(String role) {
      final route = flowType == 'login' ? '/login' : '/register';
      Navigator.pushNamed(context, route, arguments: role);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.whoAreYouTitle),
        actions: const [
          LanguageSelector(),
          SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Community Member Card
            _RoleCard(
              onTap: () => navigateToAuthScreen('community'),
              icon: Icons.people,
              color: Colors.blue,
              title: l10n.roleVillager,
              description: l10n.roleDescriptionCommunity,
            ),
            const SizedBox(height: 16),

            // Volunteer Card
            _RoleCard(
              onTap: () => navigateToAuthScreen('volunteer'),
              icon: Icons.volunteer_activism,
              color: Colors.orange,
              title: l10n.roleVolunteer,
              description: l10n.roleDescriptionVolunteer,
            ),
            const SizedBox(height: 16),

            // Doctor Card
            _RoleCard(
              onTap: () => navigateToAuthScreen('doctor'),
              icon: Icons.local_hospital,
              color: Colors.green,
              title: l10n.roleDoctor,
              description: l10n.roleDescriptionDoctor,
            ),
          ],
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final Color color;
  final String title;
  final String description;

  const _RoleCard({
    required this.onTap,
    required this.icon,
    required this.color,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 32),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: color.withOpacity(0.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
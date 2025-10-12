import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jalsetu/src/services/localization_provider.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  /// Helper function to convert Locale code ('en', 'hi') to a readable name for the dropdown.
  String _getLanguageName(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return 'English';
      case 'hi':
        return 'हिन्दी';
      default:
        return locale.languageCode.toUpperCase();
    }
  }

  @override
  Widget build(BuildContext context) {
    // We only need to read the provider here to get the current locale and call setLocale.
    // The rebuild of the app happens in main.dart when the locale changes.
    final localizationProvider = Provider.of<LocalizationProvider>(context, listen: false);

    // If the provider hasn't finished loading the preferred locale, return a placeholder.
    if (localizationProvider.currentLocale == null) {
      return const SizedBox(width: 48);
    }

    return DropdownButton<Locale>(
      value: localizationProvider.currentLocale,
      icon: const Icon(Icons.language, color: Colors.white),
      elevation: 16,
      // Match the primary color theme for the dropdown
      dropdownColor: Theme.of(context).primaryColor, 
      underline: const SizedBox.shrink(), // Remove the default underline
      onChanged: (Locale? newLocale) {
        if (newLocale != null) {
          // Call the provider method to change the language and persist it
          localizationProvider.setLocale(newLocale);
        }
      },
      items: LocalizationProvider.supportedLocales
          .map<DropdownMenuItem<Locale>>((Locale locale) {
        return DropdownMenuItem<Locale>(
          value: locale,
          child: Text(
            _getLanguageName(locale),
            style: const TextStyle(
              color: Colors.white, 
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      }).toList(),
    );
  }
}

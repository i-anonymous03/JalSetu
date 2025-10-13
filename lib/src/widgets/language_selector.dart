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

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: DropdownButton<Locale>(
        value: localizationProvider.currentLocale,
        icon: const Icon(
          Icons.translate,
          color: Colors.white,
          size: 24,
        ),
        iconSize: 24,
        elevation: 16,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        dropdownColor: Colors.black,
        underline: Container(), // Remove the default underline
        onChanged: (Locale? newLocale) {
          if (newLocale != null) {
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
      ),
    );
  }
}

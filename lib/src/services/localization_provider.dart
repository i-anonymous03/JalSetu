import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationProvider with ChangeNotifier {
  // Supported locales (English and Hindi)
  static const List<Locale> supportedLocales = [
    Locale('en'),
    Locale('hi'),
  ];
  
  // Key for local storage persistence
  static const String _languageCodeKey = 'language_code';

  Locale? _currentLocale;

  Locale? get currentLocale => _currentLocale;

  LocalizationProvider() {
    _loadPreferredLocale();
  }

  // Load the saved language code from Shared Preferences
  Future<void> _loadPreferredLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final String? savedCode = prefs.getString(_languageCodeKey);
    
    if (savedCode != null) {
      _currentLocale = Locale(savedCode);
    } else {
      // Default to English if nothing is saved
      _currentLocale = const Locale('en'); 
    }
    notifyListeners();
  }

  // Change the application locale
  void setLocale(Locale newLocale) async {
    if (_currentLocale == newLocale) return;

    _currentLocale = newLocale;
    notifyListeners();

    // Save the new locale to Shared Preferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageCodeKey, newLocale.languageCode);
  }
}

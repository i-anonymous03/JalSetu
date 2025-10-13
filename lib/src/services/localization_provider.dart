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
  bool _isLoading = true;

  Locale? get currentLocale => _currentLocale;
  bool get isLoading => _isLoading;

  LocalizationProvider() {
    // Set default locale immediately to prevent flicker
    _currentLocale = const Locale('en');
    _loadPreferredLocale();
  }

  // Load the saved language code from Shared Preferences
  Future<void> _loadPreferredLocale() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? savedCode = prefs.getString(_languageCodeKey);
      
      if (savedCode != null && savedCode != _currentLocale?.languageCode) {
        _currentLocale = Locale(savedCode);
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error loading locale: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
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

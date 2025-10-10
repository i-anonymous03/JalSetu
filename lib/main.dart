import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:jalsetu/firebase_options.dart';
import 'package:jalsetu/routes.dart';
import 'package:jalsetu/src/theme.dart';

// 🌐 Localization imports
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // ------------------------------------------------------------
      // 🌍 Localization + Theme + Routing setup for JalSetu
      // ------------------------------------------------------------

      // App title will automatically translate (once added in ARB)
      title: AppLocalizations.of(context)?.appName ?? 'JalSetu',

      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,

      // 🌐 Localization delegates (connects your .arb translation files)
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      // 🗣 Supported languages from your ARB files
      supportedLocales: AppLocalizations.supportedLocales,

      // 🧠 Auto language detection (Hindi/English based on system settings)
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale?.languageCode) {
            return supportedLocale;
          }
        }
        // Default to English if system language isn't supported
        return supportedLocales.first;
      },

      // 🧭 App navigation routes
      initialRoute: AppRoutes.root,
      routes: AppRoutes.routes,
    );
  }
}

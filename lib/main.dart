import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:jalsetu/firebase_options.dart';
import 'package:jalsetu/routes.dart';
import 'package:jalsetu/src/theme.dart';
import 'package:provider/provider.dart';
import 'package:jalsetu/src/services/localization_provider.dart';
import 'package:jalsetu/src/services/auth_service.dart';
import 'package:jalsetu/src/providers/auth_provider.dart';
import 'package:jalsetu/src/utils/custom_page_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 🌐 Localization imports
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/app_localizations.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    // Initialize Firebase and SharedPreferences
    await Future.wait([
      Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
      SharedPreferences.getInstance(),
    ]);
    
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => LocalizationProvider(),
          ),
          Provider<AuthService>(
            create: (context) => AuthService(),
          ),
          ChangeNotifierProxyProvider<AuthService, AuthProvider>(
            create: (context) => AuthProvider(context.read<AuthService>()),
            update: (context, authService, previous) =>
                previous ?? AuthProvider(authService),
          ),
        ],
        child: const MyApp(),
      ),
    );
  } catch (e) {
    print('Error initializing app: $e');
    rethrow;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 2. Consume the currentLocale from the Provider
    final localizationProvider = Provider.of<LocalizationProvider>(context);

    // Show a loading indicator until the preferred locale is loaded from local storage
    if (localizationProvider.currentLocale == null) {
      return const MaterialApp(
        home: Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      );
    }
    
    return MaterialApp(
      locale: localizationProvider.currentLocale,
      title: 'JalSetu',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: LocalizationProvider.supportedLocales,
      initialRoute: AppRoutes.root,
      routes: AppRoutes.routes,
      onGenerateRoute: (settings) {
        final routes = AppRoutes.routes;
        final Widget Function(BuildContext)? builder = routes[settings.name];
        
        if (builder == null) return null;

        // Use different animations for different route types
        if (settings.name == AppRoutes.welcome) {
          return FadePageRoute(
            settings: settings,
            child: builder(navigatorKey.currentContext!),
          );
        }

        return CustomPageRoute(
          settings: settings,
          child: builder(navigatorKey.currentContext!),
        );
      },
    );
  }
}

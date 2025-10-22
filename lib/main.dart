import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
// ignore: unnecessary_import
import 'package:flutter/foundation.dart'; // Import for debugPrint
import 'package:jalsetu/firebase_options.dart';
import 'package:jalsetu/routes.dart';
import 'package:jalsetu/src/screens/auth_wrapper.dart';
import 'package:jalsetu/src/theme.dart';
import 'package:provider/provider.dart';
import 'package:jalsetu/src/services/localization_provider.dart';
import 'package:jalsetu/src/services/auth_service.dart';
import 'package:jalsetu/src/providers/auth_provider.dart';

// 🌐 Localization imports
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/app_localizations.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const SplashApp());
}

class SplashApp extends StatefulWidget {
  const SplashApp({super.key});

  @override
  State<SplashApp> createState() => _SplashAppState();
}

class _SplashAppState extends State<SplashApp> {
  bool _initialized = false;
  bool _error = false;

  @override
  void initState() {
    super.initState();
    _initializeAsync();
  }

  Future<void> _initializeAsync() async {
    try {
      // Initialize Firebase before running the app.
      await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
      
      if(mounted) {
        setState(() {
          _initialized = true;
        });
      }
    } catch (e) {
      // FIX: Replaced print with debugPrint for better production code.
      debugPrint('Error initializing app: $e');
      if(mounted) {
        setState(() {
          _error = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_error) {
      return const MaterialApp(
        home: Scaffold(
          body: Center(
            child: Text('Error initializing app', style: TextStyle(color: Colors.red, fontSize: 20)),
          ),
        ),
      );
    }
    if (!_initialized) {
      return const MaterialApp(
        home: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 24),
                Text('Loading...', style: TextStyle(fontSize: 18)),
              ],
            ),
          ),
        ),
      );
    }
    return MultiProvider(
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
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Consume the currentLocale from the Provider
    final localizationProvider = Provider.of<LocalizationProvider>(context);
    final locale = localizationProvider.currentLocale ?? const Locale('en');

    return MaterialApp(
      locale: locale,
      title: 'JalSetu',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: LocalizationProvider.supportedLocales,
      home: const AuthWrapper(),
      routes: AppRoutes.routes,
      onGenerateRoute: (settings) {
        final routes = AppRoutes.routes;
        final routeName = settings.name;
        final Widget Function(BuildContext)? builder = routes[routeName];

        if (builder == null) {
          // FIX: Replaced print with debugPrint.
          debugPrint('[Navigation] Unknown route requested: '
              '${routeName ?? "<null>"}');
          // Fallback: show a simple error screen
          return MaterialPageRoute(
            builder: (context) => Scaffold(
              appBar: AppBar(title: const Text('Page Not Found')),
              body: Center(
                child: Text(
                  'Route not found: ${routeName ?? "<null>"}',
                  style: const TextStyle(fontSize: 18, color: Colors.red),
                ),
              ),
            ),
            settings: settings,
          );
        }

        return PageRouteBuilder(
          settings: settings,
          transitionDuration: const Duration(milliseconds: 300),
          pageBuilder: (context, animation, secondaryAnimation) {
            return builder(context);
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            if (routeName == AppRoutes.welcome) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            }

            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 0.1),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
              )),
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
        );
      },
    );
  }
}

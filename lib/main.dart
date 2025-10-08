import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:jalsetu/firebase_options.dart';
import 'package:jalsetu/routes.dart';
//import 'package:jalsetu/src/services/auth_wrapper.dart';
import 'package:jalsetu/src/theme.dart';

void main() async {
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
      title: 'JalSetu',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      
      // ❌ DELETED: Removed 'home: const AuthWrapper(),' to resolve the conflict.
      
      // ✅ ADDED: This tells the MaterialApp to use the route map and start at the '/' key.
      initialRoute: AppRoutes.root, 
      
      // ✅ KEPT: 'routes' defines all the available screens.
      routes: AppRoutes.routes,
    );
  }
}

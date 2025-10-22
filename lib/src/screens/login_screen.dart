import 'package:flutter/material.dart';
import 'package:jalsetu/generated/app_localizations.dart';
import 'package:jalsetu/src/widgets/language_selector.dart';

class LoginScreen extends StatefulWidget {
  final String role;

  const LoginScreen({super.key, required this.role});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      // TODO: Implement actual login logic
      String route = '';
      switch (widget.role) {
        case 'community':
          route = '/home';
          break;
        case 'volunteer':
          route = '/volunteer-dashboard';
          break;
        case 'doctor':
          route = '/clinic-dashboard';
          break;
      }
      Navigator.pushReplacementNamed(context, route);
    }
  }

  @override
  Widget build(BuildContext context) {
    // FIX: Make l10n nullable and add a guard clause.
    final l10n = AppLocalizations.of(context);
    if (l10n == null) {
      // Return a loading indicator while localizations are loading.
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    String getRoleTitle() {
      switch (widget.role) {
        case 'community':
          return l10n.roleVillager;
        case 'volunteer':
          return l10n.roleVolunteer;
        case 'doctor':
          return l10n.roleDoctor;
        default:
          return '';
      }
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('${l10n.signInButton} - ${getRoleTitle()}', style: const TextStyle(color: Colors.white)),
        actions: const [
          LanguageSelector(),
          SizedBox(width: 8),
        ],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                l10n.welcomeBack,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text(
                l10n.signInInstructions,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 32),
              // Email Field
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: l10n.emailPlaceholder,
                  prefixIcon: const Icon(Icons.email),
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return l10n.emailRequired;
                  }
                  final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+');
                  if (!emailRegex.hasMatch(value)) return l10n.emailInvalid;
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Password Field
              TextFormField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  labelText: l10n.passwordPlaceholder,
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(_isPasswordVisible ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return l10n.passwordRequired;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),
              // Forgot Password
              TextButton(
                onPressed: () {}, // TODO: Implement forgot password
                child: Text(
                  l10n.forgotPassword,
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
              const SizedBox(height: 24),
              // Login Button
              SizedBox(
                height: 50,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.email),
                  label: Text(l10n.signInButton),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  onPressed: _handleLogin,
                ),
              ),
              const SizedBox(height: 24),
              // Divider
              Row(
                children: [
                  const Expanded(child: Divider()),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(l10n.orDivider),
                  ),
                  const Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: 24),
              // Phone Login
              ElevatedButton.icon(
                icon: const Icon(Icons.phone),
                label: Text(l10n.phoneSignIn),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                onPressed: () {
                  // TODO: Implement phone login with OTP
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(l10n.featureComingSoon)),
                  );
                },
              ),
              const SizedBox(height: 16),
              // Google Login
              ElevatedButton.icon(
                icon: const Icon(Icons.g_mobiledata),
                label: Text(l10n.continueWithGoogle),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                onPressed: () {
                  // TODO: Implement Google Sign-In
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(l10n.featureComingSoon)),
                  );
                },
              ),
              const SizedBox(height: 16),
              // Register Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(l10n.dontHaveAccount),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                        context,
                        '/register',
                        arguments: widget.role,
                      );
                    },
                    child: Text(l10n.registerNow),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

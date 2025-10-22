import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jalsetu/src/services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService;
  User? _user;
  String? _role;
  bool _isLoading = false;

  AuthProvider(this._authService) {
    _isLoading = true; // Start in loading state to handle initial auth check
    _init();
  }

  User? get user => _user;
  String? get role => _role;
  bool get isLoading => _isLoading;

  void _init() {
    _authService.authStateChanges.listen((User? user) async {
      _user = user;
      if (user != null) {
        // Await the user role to ensure it's loaded before we stop loading.
        await _loadUserRole();
      } else {
        _role = null;
      }
      // Set loading to false only after we've determined the user and their role.
      _setLoading(false);
    });
  }

  Future<void> _loadUserRole() async {
    if (_user != null) {
      _role = await _authService.getUserRole(_user!.uid);
      // No need to notify listeners here; the listener in _init will do it.
    }
  }

  Future<void> signIn(String email, String password, String role) async {
    _setLoading(true);
    try {
      await _authService.signInWithEmailAndPassword(email, password);
      // After successful sign-in, the stream listener in _init will handle updating user and role.
    } finally {
      // The listener will set loading to false once the new state is processed.
    }
  }

  Future<void> register(
    String email,
    String password,
    String role,
    Map<String, dynamic> userData,
  ) async {
    _setLoading(true);
    try {
      await _authService.registerWithEmailAndPassword(
        email,
        password,
        role,
        userData,
      );
      // After successful registration, the stream listener will update the state.
    } finally {
      // The listener will set loading to false.
    }
  }

  Future<void> signInWithGoogle(String role) async {
    _setLoading(true);
    try {
      await _authService.signInWithGoogle(role);
      // The stream listener will handle the new auth state.
    } finally {
      // The listener will set loading to false.
    }
  }

  Future<void> signOut() async {
    _setLoading(true);
    try {
      await _authService.signOut();
      _role = null;
    } finally {
      // The listener will set loading to false after the user becomes null.
    }
  }

  Future<void> resetPassword(String email) async {
    _setLoading(true);
    try {
      await _authService.resetPassword(email);
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    if (_isLoading != value) {
      _isLoading = value;
      notifyListeners();
    }
  }

  String getHomeRoute() {
    switch (_role) {
      case 'community':
        return '/home';
      case 'volunteer':
        return '/volunteer-dashboard';
      case 'doctor':
        return '/clinic-dashboard';
      default:
        // Fallback if role is not determined yet or is invalid.
        return '/welcome';
    }
  }
}

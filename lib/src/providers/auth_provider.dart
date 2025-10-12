import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jalsetu/src/services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService;
  User? _user;
  String? _role;
  bool _isLoading = false;

  AuthProvider(this._authService) {
    _init();
  }

  User? get user => _user;
  String? get role => _role;
  bool get isLoading => _isLoading;

  void _init() {
    _authService.authStateChanges.listen((User? user) {
      _user = user;
      if (user != null) {
        _loadUserRole();
      } else {
        _role = null;
      }
      notifyListeners();
    });
  }

  Future<void> _loadUserRole() async {
    if (_user != null) {
      _role = await _authService.getUserRole(_user!.uid);
      notifyListeners();
    }
  }

  Future<void> signIn(String email, String password, String role) async {
    _setLoading(true);
    try {
      await _authService.signInWithEmailAndPassword(email, password);
      _role = role;
    } finally {
      _setLoading(false);
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
      _role = role;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> signInWithGoogle(String role) async {
    _setLoading(true);
    try {
      await _authService.signInWithGoogle(role);
      _role = role;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> signOut() async {
    _setLoading(true);
    try {
      await _authService.signOut();
      _role = null;
    } finally {
      _setLoading(false);
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
    _isLoading = value;
    notifyListeners();
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
        return '/welcome';
    }
  }
}
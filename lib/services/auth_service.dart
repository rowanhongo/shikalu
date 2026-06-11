import 'package:flutter/material.dart';

class AuthService with ChangeNotifier {
  bool _isLoggedIn = false;
  String _currentUserEmail = '';
  String _currentUserRole = '';

  bool get isLoggedIn => _isLoggedIn;
  String get currentUserEmail => _currentUserEmail;
  String get currentUserRole => _currentUserRole;

  // Simple in-memory storage for demo (no database)
  static final Map<String, Map<String, String>> _users = {};

  Future<bool> signup({
    required String email,
    required String password,
    required String fullName,
    required String role,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Check if user already exists
    if (_users.containsKey(email)) {
      return false;
    }

    // Store user data in memory
    _users[email] = {
      'password': password,
      'fullName': fullName,
      'role': role,
    };

    _isLoggedIn = true;
    _currentUserEmail = email;
    _currentUserRole = role;
    notifyListeners();
    return true;
  }

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Check if user exists and password is correct
    if (_users.containsKey(email)) {
      if (_users[email]!['password'] == password) {
        _isLoggedIn = true;
        _currentUserEmail = email;
        _currentUserRole = _users[email]!['role'] ?? 'Student';
        notifyListeners();
        return true;
      }
    }
    return false;
  }

  Future<void> logout() async {
    _isLoggedIn = false;
    _currentUserEmail = '';
    _currentUserRole = '';
    notifyListeners();
  }
}

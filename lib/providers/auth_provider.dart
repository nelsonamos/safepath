import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  String? _userToken;

  String? get userToken => _userToken;

  Future<void> login(String email, String password) async {
    try {
      await _authService.login(email, password);
      // Save user token or session details
      _userToken = 'mockToken'; // Replace with actual token
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> register(String email, String password) async {
    try {
      await _authService.register(email, password);
    } catch (e) {
      throw e;
    }
  }
}

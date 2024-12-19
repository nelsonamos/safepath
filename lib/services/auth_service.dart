import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  final String apiUrl = 'https://example.com/api/auth';

  Future<void> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$apiUrl/login'),
      body: jsonEncode({'email': email, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      // Handle successful login
      print('Login Successful: ${response.body}');
    } else {
      // Handle error
      throw Exception('Login failed');
    }
  }

  Future<void> register(String email, String password) async {
    final response = await http.post(
      Uri.parse('$apiUrl/register'),
      body: jsonEncode({'email': email, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      // Handle successful registration
      print('Registration Successful: ${response.body}');
    } else {
      // Handle error
      throw Exception('Registration failed');
    }
  }
}

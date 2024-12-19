import 'package:flutter/material.dart';

import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/categories/educational_dash.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: Colors.blue, // Primary color for app bar, buttons, etc.
          secondary: Colors.orange, // Accent color for buttons or highlights.
          error: Colors.red, // Error color
          background: Colors.white, // Default background
          onPrimary: Colors.white, // Text/icons on primary
          onSecondary: Colors.black, // Text/icons on secondary
          onSurface: Colors.black, // Text/icons on surfaces
        ),

        // Define global text styles
        textTheme: TextTheme(
          bodyLarge: TextStyle(fontSize: 18.0, color: Colors.black), // Large body text
          bodyMedium: TextStyle(fontSize: 16.0, color: Colors.black), // Medium body text
          bodySmall: TextStyle(fontSize: 14.0, color: Colors.black), // Small body text
        ),

        // Button Theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue, // Background color of ElevatedButton
            foregroundColor: Colors.white, // Text color
            textStyle: TextStyle(fontSize: 16.0),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.orange, // Text color of TextButton
          ),
        ),

        // AppBar Theme
        appBarTheme: AppBarTheme(
          color: Colors.blue, // App bar background color
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: Colors.white), // Icons in the AppBar
        ),
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/RegisterScreen': (context) => RegisterScreen(),
        '/home': (context) => HomePage(), // Add HomePage route
        '/educational_resources': (context) => EducationalResourcesScreen(),
      },
    );
  }
}

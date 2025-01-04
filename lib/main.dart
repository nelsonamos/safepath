import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

// Import your newly created pages
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/categories/educational_dash.dart';
import 'screens/home_screen.dart';
import 'screens/information_hub/EffectsScreen.dart';
import 'screens/information_hub/prevention/PreventionScreen.dart';
import 'screens/information_hub/SignsScreen.dart';
import 'screens/information_hub/UnderstandingScreen.dart';
import 'screens/lesson/sub_lesson_en/AlphabetEn.dart';
import 'screens/lesson/sub_lesson_en/ColorsEn.dart';
import 'screens/lesson/sub_lesson_en/GreetingsEn.dart';
import 'screens/lesson/sub_lesson_en/PronounsEn.dart';
import 'screens/lesson/sub_lesson_fr/Alphabet.dart';
import 'screens/lesson/sub_lesson_fr/Colors.dart';
import 'screens/lesson/sub_lesson_fr/Greetings.dart';
import 'screens/lesson/sub_lesson_fr/Pronouns.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        '/register': (context) => RegisterScreen(),
        '/home': (context) => HomePage(), // Add HomePage route
        '/alphabet': (context) => AlphabetPage(), // Alphabet Page
        '/colors': (context) => ColorsPage(), // Colors Page
        '/pronouns': (context) => PronounsPage(), // Pronouns Page
        '/greetings': (context) => GreetingsPage(), // Greetings Page
        '/educational_resources': (context) => EducationalResourcesScreen(), // Educational Resources Page
        '/alphabetEn': (context) => AlphabetEn(),
        '/colorsEn': (context) => ColorsEn(),
        '/pronounsEn': (context) => PronounsEn(),
        '/greetingsEn': (context) => GreetingsEn(),
        '/understanding': (context) => UnderstandingScreen(),
        '/prevention': (context) => PreventionScreen(),
        '/signs': (context) => SignsScreen(),
        '/effects': (context) => EffectsScreen(),
      },
    );
  }
}
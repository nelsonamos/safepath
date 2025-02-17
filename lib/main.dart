import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart'; // Import for notifications
import 'package:safepath/models/AddictionTracker.dart';
import 'package:safepath/screens/information_hub/prevention/trackinghome.dart';
import 'package:safepath/services/NotificationService.dart';
import 'package:timezone/data/latest.dart' as tz; // Import for timezone
import 'package:timezone/timezone.dart' as tz; // Import for timezone
import 'package:cloud_firestore/cloud_firestore.dart';

// Import your newly created pages
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/categories/educational_dash.dart';
import 'screens/home_screen.dart';
import 'screens/information_hub/EffectsScreen.dart';
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

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> main() async {
  tz.initializeTimeZones();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  initializeNotifications();
  configureTimeZone();

  // Initialize NotificationService
  const androidInitializationSettings = AndroidInitializationSettings('app_icon');
  const initializationSettings = InitializationSettings(android: androidInitializationSettings);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  final notificationService = NotificationService(flutterLocalNotificationsPlugin);

  runApp(MyApp(notificationService: notificationService));
}

Future<void> initializeNotifications() async {
  const initializationSettingsAndroid = AndroidInitializationSettings('app_icon'); // Ensure 'app_icon' exists

  const initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings).then((_) {
    print("Notifications Initialized");
  }).catchError((error) {
    print("Error Initializing Notifications: $error");
  });
}

void configureTimeZone() {
  tz.initializeTimeZones();
}

class MyApp extends StatelessWidget {
  final NotificationService notificationService;

  MyApp({required this.notificationService});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: Colors.blue,
          secondary: Colors.orange,
        ),
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/home': (context) => HomePage(),
        '/alphabet': (context) => AlphabetPage(),
        '/colors': (context) => ColorsPage(),
        '/pronouns': (context) => PronounsPage(),
        '/greetings': (context) => GreetingsPage(),
        '/educational_resources': (context) => EducationalResourcesScreen(),
        '/alphabetEn': (context) => AlphabetEn(),
        '/colorsEn': (context) => ColorsEn(),
        '/pronounsEn': (context) => PronounsEn(),
        '/greetingsEn': (context) => GreetingsEn(),
        '/understanding': (context) => UnderstandingScreen(),
        '/prevention': (context) => trackinghome(),
        '/signs': (context) => SignsScreen(),
        '/effects': (context) => EffectsScreen(),
        '/trackinghome': (context) => const trackinghome(),

      },
    );
  }
}

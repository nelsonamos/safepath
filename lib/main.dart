import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:safepath/chatpages/view/CommunityChatScreen.dart';
import 'package:safepath/providers/TransactionProvider.dart';
import 'package:safepath/screens/information_hub/BubbleGame.dart';
import 'package:safepath/screens/information_hub/JournalScreen.dart';
import 'package:safepath/widgets/noti.dart';
import 'chatpages/create_post_page.dart';
import 'chatpages/view/PostforumListPage.dart';
import 'chatpages/view/forum_list_page.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/categories/Resources_dashboard.dart';
import 'screens/home_screen.dart';
import 'screens/information_hub/BreathingScreen.dart';
import 'screens/lesson/sub_lesson_en/AlphabetEn.dart';
import 'screens/lesson/sub_lesson_en/ColorsEn.dart';
import 'screens/lesson/sub_lesson_en/GreetingsEn.dart';
import 'screens/lesson/sub_lesson_en/PronounsEn.dart';
import 'screens/lesson/sub_lesson_fr/Alphabet.dart';
import 'screens/lesson/sub_lesson_fr/Colors.dart';
import 'screens/lesson/sub_lesson_fr/Greetings.dart';
import 'screens/lesson/sub_lesson_fr/Pronouns.dart';
import 'package:safepath/screens/information_hub/prevention/trackinghome.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (context) => TransactionProvider(),
      child: MyApp(),
    ),
  );

  await LocalNotifications.init();
  LocalNotifications.showPeriodicNotifications(
    title: "Stay Strong on Your Journey!",
    body: "Track today’s progress and reflect on how far you’ve come.",
    payload: "daily_check_in",
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Your logout function (example)
  void logout() {
    // Set the user's status to offline or perform necessary cleanup.
    print("User logged out and set as offline");
    // You can add the logic to update the user's status in the database here
  }

  @override
  void dispose() {
    logout();  // Set isOnline to false when the app closes
    super.dispose();  // Always call the super.dispose() after cleanup
  }

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
        '/BubbleGame': (context) => BubbleGame(),
        '/prevention': (context) => trackinghome(),
        '/Journal': (context) => JournalScreen(),
        '/Breathing': (context) => Breathing(),
        '/trackinghome': (context) => const trackinghome(),
        '/posts': (context) => AllPostsPage(forumId: ''), // Placeholder
        '/createPost': (context) => CreatePostPage(forumId: ''), // Placeholder
        '/forum': (context) => ForumListPage(),

      },
      onGenerateRoute: (settings) {
        if (settings.name == '/posts') {
          final forumId = settings.arguments as String;
          return MaterialPageRoute(
            builder: (context) => AllPostsPage(forumId: forumId),
          );
        } else if (settings.name == '/createPost') {
          final forumId = settings.arguments as String;
          return MaterialPageRoute(
            builder: (context) => CreatePostPage(forumId: forumId),
          );
        }
        return null;
      },
    );
  }
}

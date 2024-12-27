import 'package:flutter/material.dart';

import 'sub_lesson_fr/Alphabet.dart';
import 'sub_lesson_fr/Colors.dart';
import 'sub_lesson_fr/Greetings.dart';
import 'sub_lesson_fr/Pronouns.dart';



class FrenchLessonScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> categories = [
      {'title': 'Alphabet', 'image': 'assets/images/alphabet.png', 'route': 'AlphabetPage'},
      {'title': 'Colors', 'image': 'assets/images/colors.png', 'route': 'ColorsPage'},
      {'title': 'Pronouns', 'image': 'assets/images/pronouns.png', 'route': 'PronounsPage'},
      {'title': 'Greetings', 'image': 'assets/images/greetings.png', 'route': 'GreetingsPage'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Learn French'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Wrap(
            spacing: 16.0, // Horizontal spacing between cards
            runSpacing: 16.0, // Vertical spacing between cards
            children: categories.map((category) {
              return SizedBox(
                width: MediaQuery.of(context).size.width / 2 - 24, // Adjust card size dynamically
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => getPage(category['route']!),
                      ),
                    );
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            radius: 30, // Compact avatar size
                            backgroundImage: AssetImage(category['image']!),
                          ),
                          SizedBox(height: 8),
                          Text(
                            category['title']!,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget getPage(String route) {
    switch (route) {
      case 'AlphabetPage':
        return AlphabetPage();
      case 'ColorsPage':
        return ColorsPage();
      case 'PronounsPage':
        return PronounsPage();
      case 'GreetingsPage':
        return GreetingsPage();
      default:
        return Center(child: Text('Page not found'));
    }
  }
}

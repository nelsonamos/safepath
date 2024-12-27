import 'package:flutter/material.dart';

import 'sub_lesson_en/AlphabetEn.dart';
import 'sub_lesson_en/ColorsEn.dart';
import 'sub_lesson_en/GreetingsEn.dart';
import 'sub_lesson_en/PronounsEn.dart';





class EnglishLessonScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> categories = [
      {'title': 'Alphabet', 'image': 'assets/images/alphabet.png', 'route': 'alphabetEn'},
      {'title': 'Colors', 'image': 'assets/images/colors.png', 'route': 'colorsEn'},
      {'title': 'Pronouns', 'image': 'assets/images/pronouns.png', 'route': 'pronounsEn'},
      {'title': 'Greetings', 'image': 'assets/images/greetings.png', 'route': 'greetingsEn'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Learn English'),
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
      case 'alphabetEn':
        return AlphabetEn();
      case 'colorsEn':
        return ColorsEn();
      case 'greetingsEn':
        return GreetingsEn();
      case 'pronounsEn':
        return PronounsEn();
      default:
        return Center(child: Text('Page not found'));
    }
  }
}

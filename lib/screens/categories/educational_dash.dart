import 'package:flutter/material.dart';
import '../lesson/french_screen.dart';
import '../lesson/english_screen.dart';


class EducationalResourcesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Educational Resources'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            // Hero Section
            heroSection(context),
            SizedBox(height: 20),
            // Information Hub Section
            sectionTitle('Information Hub', context),
            infoHubContent(context),
            SizedBox(height: 20),
            // Local Language Support Section
            sectionTitle('Local Language Support', context),
            localLanguageSupport(context),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget heroSection(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      width: double.infinity,
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/hero_background.png'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.6),
            BlendMode.darken,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Educational Resources',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            'Empowering you with knowledge and tools for a better future.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget sectionTitle(String title, BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  Widget infoHubContent(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 2 / 3,
        ),
        itemCount: 4,
        itemBuilder: (context, index) {
          return infoHubCard(context, index);
        },
      ),
    );
  }

  Widget infoHubCard(BuildContext context, int index) {
    List<Map<String, String>> infoHubItems = [
      {'title': 'Understanding the Dangers of Drug ', 'description': 'Learn about the various harmful effects of drug abuse .', 'image': 'assets/images/Understanding.png', 'route': '/understanding'},
      {'title': 'Prevention Methods', 'description': 'Discover effective ways to prevent drug abuse and protect yourself and loved ones.', 'image': 'assets/images/Prevention.png', 'route': '/prevention'},
      {'title': 'Signs of Addiction', 'description': 'Watch this video to understand the warning signs of addiction.', 'image': 'assets/images/Signs.png', 'route': '/signs'},
      {'title': 'Effects of Drug Abuse', 'description': 'A detailed infographic on how drug abuse impacts health.', 'image': 'assets/images/Effects.png', 'route': '/effects'},
    ];

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, infoHubItems[index]['route']!);
      },
      child: Card(
        elevation: 4,
        margin: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 2,
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(8.0),
                ),
                child: Image.asset(
                  infoHubItems[index]['image']!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      infoHubItems[index]['title']!,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Flexible(
                      child: Text(
                        infoHubItems[index]['description']!,
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget localLanguageSupport(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 2 / 3,
        ),
        itemCount: 2,
        itemBuilder: (context, index) {
          return languageSupportCard(context, index);
        },
      ),
    );
  }

  Widget languageSupportCard(BuildContext context, int index) {
    List<Map<String, String>> languageItems = [
      {'language': 'English', 'description': 'Access resources in English.', 'image': 'assets/images/English.png'},
      {'language': 'French', 'description': 'Access resources in French.', 'image': 'assets/images/French.png'},
    ];

    return GestureDetector(
      onTap: () {
        if (languageItems[index]['language'] == 'English') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EnglishLessonScreen()),
          );
        } else if (languageItems[index]['language'] == 'French') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FrenchLessonScreen()),
          );
        }
      },
      child: Card(
        elevation: 4,
        margin: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 2,
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(8.0),
                ),
                child: Image.asset(
                  languageItems[index]['image']!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      languageItems[index]['language']!,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 2),
                    Flexible(
                      child: Text(
                        languageItems[index]['description']!,
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

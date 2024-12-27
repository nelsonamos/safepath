import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class PronounsPage extends StatefulWidget {
  @override
  _WordsPageState createState() => _WordsPageState();
}

class _WordsPageState extends State<PronounsPage> {
  final Map<String, String> words = {
    'Hello': 'Bonjour',
    'Goodbye': 'Au revoir',
    'Please': 'S’il vous plaît',
    'Thank you': 'Merci',
    'Yes': 'Oui',
    'No': 'Non',
    'Excuse me': 'Excusez-moi',
    'Sorry': 'Désolé',
    'Good morning': 'Bon matin',
    'Good night': 'Bonne nuit',
    'How are you?': 'Comment ça va?',
    'I’m fine': 'Ça va bien',
    'What is your name?': 'Comment vous appelez-vous?',
    'My name is...': 'Je m’appelle...',
    'Where is...?': 'Où est...?',
    'How much is it?': 'Combien ça coûte?',
    'I don’t understand': 'Je ne comprends pas',
    'Help': 'Aidez-moi',
    'Water': 'Eau',
    'Food': 'Nourriture',
    'Friend': 'Ami',
    'Family': 'Famille',
    'School': 'Ecole',
    'Work': 'Travail',
    'Happy': 'Heureux',
    'Sad': 'Triste',
    'Beautiful': 'Beau',
    'Big': 'Grand',
    'Small': 'Petit'
  };

  final FlutterTts flutterTts = FlutterTts();
  bool _isTtsInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeTts();
    _checkAvailableLanguages(); // Check available languages
  }

  void _initializeTts() async {
    try {
      await flutterTts.awaitSpeakCompletion(true);
      var isFrenchAvailable = await flutterTts.isLanguageAvailable("fr-FR");
      if (isFrenchAvailable) {
        await flutterTts.setLanguage("fr-FR");
      } else {
        await flutterTts.setLanguage("en-US"); // Fallback to English
      }
      await flutterTts.setSpeechRate(0.5);
      await flutterTts.setVolume(1.0);
      setState(() {
        _isTtsInitialized = true;
      });
    } catch (e) {
      print("Error initializing TTS: $e");
    }
  }

  void _checkAvailableLanguages() async {
    List<dynamic> languages = await flutterTts.getLanguages;
    print("Available Languages: $languages");
  }

  Future<void> _speak(String word) async {
    if (!_isTtsInitialized) {
      print("TTS is not initialized yet.");
      return;
    }
    try {
      await flutterTts.stop();
      await flutterTts.speak(word);
    } catch (e) {
      print("Error while speaking: $e");
    }
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Learn Basic French Words'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Wrap(
                spacing: 16.0,
                runSpacing: 16.0,
                children: words.entries.map((entry) {
                  String englishWord = entry.key;
                  String frenchWord = entry.value;
                  return SizedBox(
                    width: MediaQuery.of(context).size.width / 2 - 24,
                    child: GestureDetector(
                      onTap: () {
                        _speak(frenchWord); // Speak French word on tap
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                englishWord,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                frenchWord,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontStyle: FontStyle.italic,
                                  color: Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                              SizedBox(height: 8),
                              IconButton(
                                icon: Icon(
                                  Icons.volume_up,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                onPressed: () async {
                                  await _speak(frenchWord);
                                },
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
        ],
      ),
    );
  }
}

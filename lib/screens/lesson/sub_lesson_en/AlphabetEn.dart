import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class AlphabetEn extends StatefulWidget {
  @override
  _AlphabetEnPageState createState() => _AlphabetEnPageState();
}

class _AlphabetEnPageState extends State<AlphabetEn> {
  final List<String> alphabet = [
    'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'
  ];

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
      var isEnglishAvailable = await flutterTts.isLanguageAvailable("en-US");
      if (isEnglishAvailable) {
        await flutterTts.setLanguage("en-US");
      } else {
        await flutterTts.setLanguage("en-US"); // Fallback to English (should be available)
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

  Future<void> _speak(String letter) async {
    if (!_isTtsInitialized) {
      print("TTS is not initialized yet.");
      return;
    }
    try {
      await flutterTts.stop();
      await flutterTts.speak(letter);
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
        title: Text('Learn the English Alphabet'),
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
                children: alphabet.map((letter) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width / 2 - 24,
                    child: GestureDetector(
                      onTap: () {
                        _speak(letter); // Speak letter on tap
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 4,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/images/letter_image.png', // Change to your image file
                              fit: BoxFit.cover,
                              height: 100,
                              width: double.infinity,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    letter,
                                    style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          Icons.volume_up,
                                          color: Theme.of(context).colorScheme.primary,
                                        ),
                                        onPressed: () async {
                                          await _speak(letter);
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
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

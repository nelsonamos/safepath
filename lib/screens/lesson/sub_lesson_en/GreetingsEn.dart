import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class GreetingsEn extends StatefulWidget {
  @override
  _GreetingsPageState createState() => _GreetingsPageState();
}

class _GreetingsPageState extends State<GreetingsEn> {
  final Map<String, String> greetings = {
    'Hello': 'Hello',
    'Goodbye': 'Goodbye',
    'Good morning': 'Good morning',
    'Good night': 'Good night',
    'How are you?': 'How are you?',
    'I’m fine': 'I’m fine',
    'What is your name?': 'What is your name?',
    'My name is...': 'My name is...',
    'Nice to meet you': 'Nice to meet you',
    'See you soon': 'See you soon',
    'Take care': 'Take care',
    'Have a good day': 'Have a good day'
  };

  final FlutterTts flutterTts = FlutterTts();
  bool _isTtsInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeTts();
  }

  void _initializeTts() async {
    try {
      await flutterTts.awaitSpeakCompletion(true);
      await flutterTts.setLanguage("en-US"); // Ensures English is the default language
      await flutterTts.setSpeechRate(0.5);
      await flutterTts.setVolume(1.0);
      setState(() {
        _isTtsInitialized = true;
      });
    } catch (e) {
      print("Error initializing TTS: $e");
    }
  }

  Future<void> _speak(String greeting) async {
    if (!_isTtsInitialized) {
      print("TTS is not initialized yet.");
      return;
    }
    try {
      await flutterTts.stop();
      await flutterTts.speak(greeting);
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
        title: Text('Learn English Greetings'),
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
                children: greetings.entries.map((entry) {
                  String greeting = entry.key;
                  return SizedBox(
                    width: MediaQuery.of(context).size.width / 2 - 24,
                    child: GestureDetector(
                      onTap: () {
                        _speak(greeting); // Speak the English greeting on tap
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
                                greeting,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              SizedBox(height: 8),
                              IconButton(
                                icon: Icon(
                                  Icons.volume_up,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                onPressed: () async {
                                  await _speak(greeting);
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

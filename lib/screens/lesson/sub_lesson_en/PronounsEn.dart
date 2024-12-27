import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class PronounsEn extends StatefulWidget {
  @override
  _PronounsPageState createState() => _PronounsPageState();
}

class _PronounsPageState extends State<PronounsEn> {
  final Map<String, String> pronouns = {
    'I': 'I',
    'You': 'You',
    'He': 'He',
    'She': 'She',
    'It': 'It',
    'We': 'We',
    'They': 'They'
  };

  final FlutterTts flutterTts = FlutterTts();
  bool _isTtsInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeTts();
  }

  void _initializeTts() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setVolume(1.0);
    setState(() {
      _isTtsInitialized = true;
    });
  }

  Future<void> _speak(String pronoun) async {
    if (!_isTtsInitialized) {
      print("TTS is not initialized yet.");
      return;
    }
    await flutterTts.stop();
    await flutterTts.speak(pronoun);
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
        title: Text('Learn Pronouns'),
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
                children: pronouns.entries.map((entry) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width / 2 - 24,
                    child: GestureDetector(
                      onTap: () => _speak(entry.key),
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
                                entry.key,
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
                                onPressed: () => _speak(entry.key),
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

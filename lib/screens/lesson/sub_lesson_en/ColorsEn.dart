import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class ColorsEn extends StatefulWidget {
  @override
  _ColorsEnPageState createState() => _ColorsEnPageState();
}

class _ColorsEnPageState extends State<ColorsEn> {
  final Map<String, Color> colors = {
    'Red': Colors.red,
    'Blue': Colors.blue,
    'Green': Colors.green,
    'Yellow': Colors.yellow,
    'Orange': Colors.orange,
    'Purple': Colors.purple,
    'Pink': Colors.pink,
    'Brown': Colors.brown,
    'Black': Colors.black,
    'White': Colors.white,
    'Gray': Colors.grey,
    'Turquoise': Colors.cyan,
    'Beige': Color(0xFFF5F5DC),
    'Burgundy': Color(0xFF800020),
    'Coral': Color(0xFFFF7F50),
    'Emerald': Color(0xFF50C878),
    'Fuchsia': Color(0xFFFF00FF),
    'Lavender': Color(0xFFE6E6FA),
    'Magenta': Color(0xFFFF00FF),
    'Peach': Color(0xFFFFE5B4),
    'Sand': Color(0xFFC2B280),
    'Cyan': Colors.cyan,
    'Silver': Color(0xFFC0C0C0),
    'Gold': Color(0xFFFFD700),
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
      var isEnglishAvailable = await flutterTts.isLanguageAvailable("en-US");
      if (isEnglishAvailable) {
        await flutterTts.setLanguage("en-US");
      } else {
        await flutterTts.setLanguage("fr-FR"); // Fallback to French if English is unavailable
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

  Future<void> _speak(String colorName) async {
    if (!_isTtsInitialized) {
      print("TTS is not initialized yet.");
      return;
    }
    try {
      await flutterTts.stop();
      await flutterTts.speak(colorName);
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
        title: Text('Learn Colors in English'),
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
                children: colors.entries.map((entry) {
                  String colorName = entry.key;
                  Color colorValue = entry.value;
                  return SizedBox(
                    width: MediaQuery.of(context).size.width / 2 - 24,
                    child: GestureDetector(
                      onTap: () {
                        _speak(colorName); // Speak color name on tap
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 4,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 100,
                              width: double.infinity,
                              color: colorValue, // Show color swatch
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    colorName,
                                    style: TextStyle(
                                      fontSize: 24,
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
                                          await _speak(colorName);
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

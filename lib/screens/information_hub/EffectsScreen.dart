import 'package:flutter/material.dart';

class EffectsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Effects of Drug Abuse'),
      ),
      body: Center(
        child: Text(
          'Content about the effects of drug abuse.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

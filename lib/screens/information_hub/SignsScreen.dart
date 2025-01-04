import 'package:flutter/material.dart';

class SignsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signs of Addiction'),
      ),
      body: Center(
        child: Text(
          'Content about signs of addiction.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

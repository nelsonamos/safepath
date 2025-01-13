import 'package:flutter/material.dart';
import 'package:safepath/screens/information_hub/prevention/DataUsagePage.dart';
import 'package:safepath/screens/information_hub/prevention/prevention_dashboard.dart';

class PrivacyFundamentalsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Fundamentals'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.privacy_tip,
                size: 100,
                color: Colors.blue,
              ),
              SizedBox(height: 16),
              Text(
                'Privacy Fundamentals',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Privacy is fundamental to sobriety. We use your data to generate anonymous statistics. We never share or sell your information. Also, by agreeing, you are confirming that you are at least 18 years of age.',
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Text(
                'Is this okay with you?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DashboardPage()),
                  );
                },
                child: Text('Agree'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DataUsagePage()),
                  );
                },
                child: Text('How We Use Your Data'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class DataUsagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('How We Use Your Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                    'ADDICTION START DATE: We use your start dates to create counts of people that are approaching milestones. This can be nice to know that you are not alone on your journey.\n\n'
                    'ANSWER TO QUESTIONS: Upon reaching a milestone, we may ask you questions about your experience in reaching these milestones. We then show these answers on our milestone screen. This can help others better understand what they can expect on their journey.\n\n'
                    'CRASH DATA: When the app crashes, data is sent to us automatically that can help us debug issues and improve the quality of the app.',
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

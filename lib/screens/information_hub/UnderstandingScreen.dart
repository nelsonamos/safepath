import 'package:flutter/material.dart';

class UnderstandingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dangers of Drug Abuse'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sectionTitle('Causes of Drug Abuse'),
            sectionContent(
                '• Economic Factors: Poverty and unemployment are significant contributors to drug abuse in Nigeria.\n'
                    '• Social Factors: Peer pressure, decline of family value systems, and social media influence play a role.\n'
                    '• Accessibility: The proliferation of the market with individuals who sell medicines and lack of control of prescription in healthcare facilities.'
            ),
            SizedBox(height: 20),
            sectionTitle('Commonly Abused Drugs'),
            sectionContent(
                '• Cannabis: The most widely used drug among young Nigerians.\n'
                    '• Sedatives, Heroin, Cocaine: Other commonly abused substances.\n'
                    '• Non-medical Use of Prescription Opioids: A growing concern.'
            ),
            SizedBox(height: 20),
            sectionTitle('Health Implications'),
            sectionContent(
                '• Physical Health: Drug abuse can lead to abnormal heart rates, heart attacks, collapsed veins, infections in heart valves, and severe muscle cramping.\n'
                    '• Infections: Increased risk of contracting diseases like hepatitis B, hepatitis C, and HIV due to unsafe practices.'
            ),
            SizedBox(height: 20),
            sectionTitle('Social and Legal Consequences'),
            sectionContent(
                '• Crime: Drug abuse is linked to criminal activities such as theft, burglary, and sex work.\n'
                    '• Legal Issues: Legal consequences include potential unemployment due to failed drug tests and driving under the influence.'
            ),
            SizedBox(height: 20),
            sectionTitle('Impact on the Community'),
            sectionContent(
                '• Youth: Drug abuse has a significant impact on the youth, rendering them unproductive and affecting the overall sustainable development of the nation.\n'
                    '• Public Health: It is a major public health issue, contributing to the spread of infectious diseases and the degradation of social structures.'
            ),
            SizedBox(height: 20),
            sectionTitle('Solutions and Prevention'),
            sectionContent(
                '• Education and Awareness: Increasing awareness about the dangers of drug abuse through educational programs.\n'
                    '• Support Systems: Strengthening family value systems and providing support for those affected.\n'
                    '• Regulation and Enforcement: Improving the control of prescription drugs and enforcing stricter penalties for drug traffickers.'
            ),
          ],
        ),
      ),
    );
  }

  Widget sectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  Widget sectionContent(String content) {
    return Text(
      content,
      style: TextStyle(
        fontSize: 16,
        color: Colors.black87,
      ),
    );
  }
}

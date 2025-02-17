import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:safepath/models/AddictionTracker.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late Future<List<AddictionTrackers>> futureTrackers;

  @override
  void initState() {
    super.initState();
    futureTrackers = _fetchTrackers();
  }

  Future<List<AddictionTrackers>> _fetchTrackers() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final email = prefs.getString('email');
      if (email == null) {
        return Future.error('User email not found. Please log in again.');
      }
      return await getAddictionTrackersByEmail(email);
    } catch (e) {
      print('Error fetching addiction trackers: $e');
      return Future.error('Error fetching addiction trackers: $e');
    }
  }

  Future<List<AddictionTrackers>> getAddictionTrackersByEmail(String email) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('addictionTrackers')
          .where('email', isEqualTo: email)
          .get();
      return querySnapshot.docs.map((doc) {
        return AddictionTrackers.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print('Error fetching addiction trackers from Firestore: $e');
      throw Exception('Failed to fetch data from Firestore. Please try again.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Addiction Trackers'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                futureTrackers = _fetchTrackers();
              });
            },
          ),
        ],
      ),
      body: FutureBuilder<List<AddictionTrackers>>(
        future: futureTrackers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, color: Colors.red, size: 60),
                  SizedBox(height: 10),
                  Text(
                    'Something went wrong!',
                    style: TextStyle(fontSize: 16, color: Colors.red),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Please try again later.',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.sentiment_dissatisfied, color: Colors.grey, size: 60),
                  SizedBox(height: 10),
                  Text(
                    'No addiction trackers found.',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Please add a new tracker to get started.',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            );
          } else {
            List<AddictionTrackers> trackers = snapshot.data!;
            return ListView.builder(
              itemCount: trackers.length,
              itemBuilder: (context, index) {
                AddictionTrackers tracker = trackers[index];
                return buildProgressCard(tracker);
              },
            );
          }
        },
      ),
    );
  }

  Widget buildProgressCard(AddictionTrackers tracker) {
    int soberDays = tracker.soberStartDate != null ? DateTime.now().difference(tracker.soberStartDate!).inDays : 0;
    int usageCount = tracker.usageCount;
    int pledgeCompletion = (tracker.dailyPledgeTime != null && tracker.dailyReviewTime != null) ? 100 : 0;

    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Addiction: ${tracker.addiction}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Days Sober: $soberDays',
              style: TextStyle(fontSize: 16, color: Colors.green),
            ),
            SizedBox(height: 5),
            Text(
              'Usage Reduction: $usageCount times',
              style: TextStyle(fontSize: 16, color: Colors.blueAccent),
            ),
            SizedBox(height: 5),
            Text(
              'Pledge Completion: $pledgeCompletion%',
              style: TextStyle(
                fontSize: 16,
                color: pledgeCompletion == 100 ? Colors.green : Colors.red,
              ),
            ),
            SizedBox(height: 10),
            LinearProgressIndicator(
              value: (soberDays / 30).clamp(0.0, 1.0), // Prevent exceeding 100%
              backgroundColor: Colors.grey[300],
              color: Colors.green,
              minHeight: 8,
            ),
            SizedBox(height: 10),
            Text(
              soberDays >= 30
                  ? 'Great job! You hit your 30-day goal!'
                  : 'Keep going! Only ${30 - soberDays} days to reach your goal.',
              style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.blueAccent),
            ),
          ],
        ),
      ),
    );
  }
}

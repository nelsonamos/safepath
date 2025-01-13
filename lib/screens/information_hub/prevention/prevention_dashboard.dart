import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:safepath/models/AddictionTracker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();

}

class _DashboardPageState extends State<DashboardPage> {

  late Future<List<AddictionTrackers>> futureTrackers;

  @override
  void initState() {
    super.initState();
    // Initialize futureTrackers with an empty Future
    futureTrackers = Future.value([]);
    _fetchTrackers();
  }

  Future<void> _fetchTrackers() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final email = prefs.getString('email');

      if (email != null) {
        setState(() {
          futureTrackers = getAddictionTrackersByEmail(email);
        });
      } else {
        throw Exception('No email found in Shared Preferences');
      }
    } catch (e) {
      setState(() {
        futureTrackers = Future.error(e);
      });
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
      throw Exception('Error fetching addiction trackers: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Addiction Trackers')),
      body: FutureBuilder<List<AddictionTrackers>>(
        future: futureTrackers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data found.'));
          } else {
            List<AddictionTrackers> trackers = snapshot.data!;
            return ListView.builder(
              itemCount: trackers.length,
              itemBuilder: (context, index) {
                AddictionTrackers tracker = trackers[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Addiction: ${tracker.addiction}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Text('Reason to Stay Sober: ${tracker.reasonToStaySober}', style: TextStyle(fontSize: 16)),
                        if (tracker.soberStartDate != null)
                          Text('Sober Since: ${DateFormat.yMMMd().format(tracker.soberStartDate!)}', style: TextStyle(fontSize: 16)),
                        Text('Usage Count: ${tracker.usageCount}', style: TextStyle(fontSize: 16)),
                        Text('Total Substance Usage Count: ${tracker.substanceUsageCount}', style: TextStyle(fontSize: 16)),
                        if (tracker.dailyPledgeTime != null)
                          Text('Daily Pledge Time: ${AddictionTrackers.formatTimeOfDay(tracker.dailyPledgeTime!)}', style: TextStyle(fontSize: 16)),
                        if (tracker.dailyReviewTime != null)
                          Text('Daily Review Time: ${AddictionTrackers.formatTimeOfDay(tracker.dailyReviewTime!)}', style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

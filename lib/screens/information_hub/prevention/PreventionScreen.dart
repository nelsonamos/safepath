import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:safepath/models/AddictionTracker.dart';
import 'package:safepath/screens/information_hub/prevention/prevention_dashboard.dart';

class PreventionScreen extends StatefulWidget {
  @override
  _AddictionTrackerPageState createState() => _AddictionTrackerPageState();
}

class _AddictionTrackerPageState extends State<PreventionScreen> {
  final _formKey = GlobalKey<FormState>();
  String addiction = '';
  DateTime? soberStartDate;
  int usageCount = 0;
  int substanceUsageCount = 0;
  String reasonToStaySober = '';
  TimeOfDay? dailyPledgeTime;
  TimeOfDay? dailyReviewTime;

  Future<void> _saveData() async {
    // Retrieve logged-in user's email from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');

    // Construct addictionTracker data
    final addictionTracker = AddictionTrackers(
      addiction: addiction,
      soberStartDate: soberStartDate,
      usageCount: usageCount,
      substanceUsageCount: substanceUsageCount,
      reasonToStaySober: reasonToStaySober,
      dailyPledgeTime: dailyPledgeTime,
      dailyReviewTime: dailyReviewTime,
      email: email, // Add userEmail to the data
    ).toMap();

    try {
      // Add data to Firestore collection "addictionTrackers"
      await FirebaseFirestore.instance.collection('addictionTrackers').add(addictionTracker);

      // Navigate to the DashboardPage after successful data storage
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DashboardPage()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving data: $e')),
      );
    }
  }

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: soberStartDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != soberStartDate) {
      setState(() {
        soberStartDate = picked;
      });
    }
  }

  Future<void> _pickTime(BuildContext context, bool isPledgeTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isPledgeTime ? dailyPledgeTime ?? TimeOfDay.now() : dailyReviewTime ?? TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        if (isPledgeTime) {
          dailyPledgeTime = picked;
        } else {
          dailyReviewTime = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Addiction Tracker'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Addiction field
              Text('Addiction', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(border: OutlineInputBorder()),
                onChanged: (value) {
                  setState(() {
                    addiction = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your addiction';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Sober Start Date
              Text('Sober Start Date', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(child: Text(soberStartDate != null ? DateFormat('yyyy-MM-dd').format(soberStartDate!) : 'Select a date')),
                  TextButton(onPressed: () => _pickDate(context), child: Text('Pick Date')),
                ],
              ),
              SizedBox(height: 16),

              // Usage Count
              Text('Usage Count', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(border: OutlineInputBorder()),
                onChanged: (value) {
                  setState(() {
                    usageCount = int.tryParse(value) ?? 0;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the usage count';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Substance Usage Count
              Text('Substance Usage Count', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(border: OutlineInputBorder()),
                onChanged: (value) {
                  setState(() {
                    substanceUsageCount = int.tryParse(value) ?? 0;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the substance usage count';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Reason to Stay Sober
              Text('Reason to Stay Sober', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(border: OutlineInputBorder()),
                onChanged: (value) {
                  setState(() {
                    reasonToStaySober = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your reason to stay sober';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Daily Pledge Time
              Text('Daily Pledge Time', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(child: Text(dailyPledgeTime != null ? dailyPledgeTime!.format(context) : 'Select a time')),
                  TextButton(onPressed: () => _pickTime(context, true), child: Text('Pick Time')),
                ],
              ),
              SizedBox(height: 16),

              // Daily Review Time
              Text('Daily Review Time', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(child: Text(dailyReviewTime != null ? dailyReviewTime!.format(context) : 'Select a time')),
                  TextButton(onPressed: () => _pickTime(context, false), child: Text('Pick Time')),
                ],
              ),
              SizedBox(height: 16),

              // Submit button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _saveData();
                    }
                  },
                  child: Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

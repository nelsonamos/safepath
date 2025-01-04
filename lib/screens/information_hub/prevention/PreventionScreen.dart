import 'package:flutter/material.dart';
import 'package:safepath/screens/information_hub/prevention/privacy.dart';

class PreventionScreen extends StatefulWidget {
  @override
  _AddictionTrackerPageState createState() => _AddictionTrackerPageState();
}

class _AddictionTrackerPageState extends State<PreventionScreen> {
  final _formKey = GlobalKey<FormState>();
  String addiction = '';
  DateTime? soberStartDate;
  int usageCount = 0;
  int cocaineUsageCount = 0;
  String reasonToStaySober = '';
  TimeOfDay? dailyPledgeTime;
  TimeOfDay? dailyReviewTime;

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
              Text(
                'Addiction',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
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
              Text(
                'Sober Journey Start Date',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      soberStartDate = pickedDate;
                    });
                  }
                },
                validator: (value) {
                  if (soberStartDate == null) {
                    return 'Please select a date';
                  }
                  return null;
                },
                controller: TextEditingController(
                  text: soberStartDate != null
                      ? '${soberStartDate!.day}/${soberStartDate!.month}/${soberStartDate!.year}'
                      : '',
                ),
              ),
              SizedBox(height: 16),
              Text(
                'How many times did you use a substance?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
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
              Text(
                'On days you used cocaine, how many times did you use it?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    cocaineUsageCount = int.tryParse(value) ?? 0;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the cocaine usage count';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Text(
                'Reason to Stay Sober',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
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
              Text(
                'Daily Pledge Time',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                readOnly: true,
                onTap: () async {
                  TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (pickedTime != null) {
                    setState(() {
                      dailyPledgeTime = pickedTime;
                    });
                  }
                },
                validator: (value) {
                  if (dailyPledgeTime == null) {
                    return 'Please select a time';
                  }
                  return null;
                },
                controller: TextEditingController(
                  text: dailyPledgeTime != null
                      ? dailyPledgeTime!.format(context)
                      : '',
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Daily Review Time',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                readOnly: true,
                onTap: () async {
                  TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (pickedTime != null) {
                    setState(() {
                      dailyReviewTime = pickedTime;
                    });
                  }
                },
                validator: (value) {
                  if (dailyReviewTime == null) {
                    return 'Please select a time';
                  }
                  return null;
                },
                controller: TextEditingController(
                  text: dailyReviewTime != null
                      ? dailyReviewTime!.format(context)
                      : '',
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Process the data
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Data submitted successfully')),
                    );
                    // Navigate to the PrivacyFundamentalsPage
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PrivacyFundamentalsPage()),
                    );
                  }
                },
                child: Text('Submit'),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

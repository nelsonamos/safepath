import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserDetailsPage extends StatefulWidget {
  @override
  _UserDetailsPageState createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emergencyContactController = TextEditingController();
  final TextEditingController _occupationController = TextEditingController();

  XFile? _profile_picture;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickprofile_picture() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _profile_picture = pickedImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _firstNameController,
                decoration: InputDecoration(
                  labelText: 'First Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _lastNameController,
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _emergencyContactController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Emergency Contact',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _occupationController,
                decoration: InputDecoration(
                  labelText: 'Occupation',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  _profile_picture != null
                      ? CircleAvatar(
                    backgroundImage: FileImage(
                      File(_profile_picture!.path),
                    ),
                    radius: 40,
                  )
                      : CircleAvatar(
                    child: Icon(Icons.person),
                    radius: 40,
                  ),
                  SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: _pickprofile_picture,
                    child: Text('Pick Profile Picture'),
                  ),
                ],
              ),
              SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Collect and print data (for now)
                    print('First Name: ${_firstNameController.text}');
                    print('Last Name: ${_lastNameController.text}');
                    print('Phone: ${_phoneController.text}');
                    print('Emergency Contact: ${_emergencyContactController.text}');
                    print('Occupation: ${_occupationController.text}');
                    if (_profile_picture != null) {
                      print('Profile Picture: ${_profile_picture!.path}');
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

import 'dart:io';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/user.dart';
import 'login_screen.dart';  // Import the LoginScreen

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emergencyContactController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  XFile? _profilePicture;
  final ImagePicker _picker = ImagePicker();
  DateTime? _sobrietyDate;

  String? _selectedObsession;

  Future<void> _pickProfilePicture() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _profilePicture = pickedImage;
    });
  }

  Future<void> _pickSobrietyDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        _sobrietyDate = pickedDate;
      });
    }
  }

  Future<void> _saveUserData() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Passwords do not match!')),
      );
      return;
    }

    if (_firstNameController.text.isEmpty ||
        _lastNameController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _emergencyContactController.text.isEmpty ||
        _selectedObsession == null ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields!')),
      );
      return;
    }

    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      user newUser = user(
        first_name: _firstNameController.text,
        last_name: _lastNameController.text,
        phone: _phoneController.text,
        emergencyContact: _emergencyContactController.text,
        obsession: _selectedObsession!,
        email: _emailController.text,
        password: _passwordController.text,
        profile_picture: _profilePicture?.path,
        sobrietyDate: _sobrietyDate,
        isOnline: false, // Set default to false at registration
      );

      await firestore.collection('user').add(newUser.toMap());

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User data saved successfully!')),
      );

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save user data: $e')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
        backgroundColor: Colors.blue,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/registration.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
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
                      filled: true,
                      fillColor: Colors.white70,
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _lastNameController,
                    decoration: InputDecoration(
                      labelText: 'Last Name',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white70,
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white70,
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _emergencyContactController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Emergency Contact',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white70,
                    ),
                  ),
                  SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _selectedObsession,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedObsession = newValue;
                      });
                    },
                    items: [
                      'Mental Health Counseling',
                      'Career Development & Guidance',
                      'Academic & School Counseling',
                      'Marriage & Family Therapy',
                    ].map((obsession) {
                      return DropdownMenuItem<String>(
                        value: obsession,
                        child: Text(obsession),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      labelText: 'Advisory Interest',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white70,
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white70,
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white70,
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _confirmPasswordController,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white70,
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _pickSobrietyDate,
                    child: Text('Pick Sobriety Start Date'),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      _profilePicture != null
                          ? CircleAvatar(
                        backgroundImage: FileImage(
                          File(_profilePicture!.path),
                        ),
                        radius: 40,
                      )
                          : CircleAvatar(
                        child: Icon(Icons.person),
                        radius: 40,
                      ),
                      SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: _pickProfilePicture,
                        child: Text('Pick Profile Picture'),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  Center(
                    child: ElevatedButton(
                      onPressed: _saveUserData,
                      child: Text('Submit'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

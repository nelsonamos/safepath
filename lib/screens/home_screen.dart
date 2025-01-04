import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/user.dart'; // Make sure this path is correct for your User model
import 'categories/educational_dash.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  user? _loggedInUser;

  @override
  void initState() {
    super.initState();
    checkUserLoggedIn();
  }

  void checkUserLoggedIn() async {
    String? userId = await getCurrentUserId();
    if (userId == null) {
      print('No user is signed in');
    } else {
      fetchUserData(userId);
    }
  }

  Future<void> fetchUserData(String userId) async {
    try {
      // Create a DocumentReference for the user document
      DocumentReference docRef = FirebaseFirestore.instance.collection('user').doc(userId);

      // Get the document snapshot from the reference
      DocumentSnapshot doc = await docRef.get();

      if (doc.exists && doc.data() != null) {
        setState(() {
          // Assuming 'User' is a model class, populate it with Firestore data
          _loggedInUser = user.fromFirestore(doc);
        });
        print('User data: ${doc.data()}');
      } else {
        print('No document found for UID: $userId');
      }
    } catch (e) {
      print('Error fetching user data: ${e.toString()}');
    }
  }

  Future<String?> getCurrentUserId() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     return prefs.getString('userId');

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: _loggedInUser != null && _loggedInUser!.profile_picture != null
                            ? FileImage(File(_loggedInUser!.profile_picture!))
                            : AssetImage('assets/images/user_avatar.jpg') as ImageProvider,
                      ),
                      SizedBox(height: 8),
                    ],
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Text(
                        _loggedInUser != null ? 'Welcome, ${_loggedInUser!.first_name}!' : 'Welcome!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),



            drawerItem(Icons.home, 'Educational Resources', context),
            drawerItem(Icons.settings, 'Rehabilitation and Counseling', context),
            drawerItem(Icons.group, 'Community Support', context),
            drawerItem(Icons.work, 'Job and Skill Training', context),
            drawerItem(Icons.attach_money, 'Revenue Generation', context),
            drawerItem(Icons.volunteer_activism, 'Donations', context),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Section
            heroSection(context),
            SizedBox(height: 20),

            // Feature Overview Section
            sectionTitle('Key Features'),
            featureOverview(context), // Pass the context to the function

            SizedBox(height: 20),

            // Testimonial Section
            sectionTitle('What People Say'),
            testimonialSection(),

            SizedBox(height: 20),

            // Quick Access to Resources Section
            sectionTitle('Quick Access to Resources'),
            quickAccessSearchBar(),

            SizedBox(height: 20),

            // Progress Tracking Section
            sectionTitle('Track Your Progress'),
            progressTrackingButton(context),

            SizedBox(height: 20),

            // Footer
            footerSection(),
          ],
        ),
      ),
    );
  }

  Widget featureOverview(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EducationalResourcesScreen()),
              );
            },
            child: featureTileContent(Icons.menu_book, 'Educational Resources', context),
          ),
          GestureDetector(
            onTap: () {},
            child: featureTileContent(Icons.health_and_safety, 'Rehabilitation and Counseling', context),
          ),
          GestureDetector(
            onTap: () {},
            child: featureTileContent(Icons.group, 'Community Support', context),
          ),
          GestureDetector(
            onTap: () {},
            child: featureTileContent(Icons.work, 'Job and Skill Training', context),
          ),
          GestureDetector(
            onTap: () {},
            child: featureTileContent(Icons.work, 'Services', context),
          ),
          GestureDetector(
            onTap: () {},
            child: featureTileContent(Icons.attach_money, 'Revenue Generation', context),
          ),
        ],
      ),
    );
  }

  Widget featureTileContent(IconData icon, String title, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        width: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Theme.of(context).colorScheme.primary),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget heroSection(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4, // Set a fixed height (e.g., 40% of the screen height)
      width: double.infinity, // Ensure the container takes the full width of the screen
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/hero_background.png'),
          fit: BoxFit.cover, // This ensures the image covers the container without distortion
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.6),
            BlendMode.darken,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,  // Vertically center the content
        crossAxisAlignment: CrossAxisAlignment.center, // Horizontally center the content
        children: [
          Text(
            'Welcome to Your Journey',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,  // Ensure the text is centered
          ),
          SizedBox(height: 10),
          Text(
            'Empowering you with resources for a better tomorrow.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,  // Ensure the text is centered
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            child: Text('Get Started'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget testimonialSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Center(  // Center the entire Testimonial Section
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal, // Enable horizontal scrolling
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center, // Center the Row's children
            children: [
              TestimonialCard(
                quote: "This platform changed my life!",
                author: "Jane Doe",
              ),
              SizedBox(width: 10), // Space between cards
              TestimonialCard(
                quote: "Incredible support and resources.",
                author: "John Smith",
              ),
              SizedBox(width: 10), // Space between cards
              // Add more TestimonialCards here if needed
            ],
          ),
        ),
      ),
    );
  }

  Widget quickAccessSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Search for rehab centers, courses, or counselors',
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }

  Widget progressTrackingButton(BuildContext context) {
    return Center(
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: Icon(Icons.track_changes),
        label: Text('Track Progress'),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
      ),
    );
  }

  Widget footerSection() {
    return Container(
      color: Colors.grey[200],
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Emergency Helplines:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text('• 123-456-7890'),
          Text('• 987-654-3210'),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.facebook, color: Colors.blue),
              IconButton(
                icon: FaIcon(FontAwesomeIcons.twitter),
                onPressed: () {
                  // Your action
                },
              ),
              IconButton(
                icon: FaIcon(FontAwesomeIcons.instagram),
                onPressed: () {
                  // Your action
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget drawerItem(IconData icon, String title, BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }
}

class TestimonialCard extends StatelessWidget {
  final String quote;
  final String author;

  TestimonialCard({required this.quote, required this.author});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              '"$quote"',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 8),
            Text(
              '- $author',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

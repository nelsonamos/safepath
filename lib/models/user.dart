import 'package:cloud_firestore/cloud_firestore.dart';

class user {
  String first_name;
  String last_name;
  String phone;
  String emergencyContact;
  String occupation;
  String email;
  String password;
  String? profile_picture;
  DateTime? sobrietyDate;

  // Constructor for the user class
  user({
    required this.first_name,
    required this.last_name,
    required this.phone,
    required this.emergencyContact,
    required this.occupation,
    required this.email,
    required this.password,
    this.profile_picture,
    this.sobrietyDate,
  });

  // Convert user object to map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'first_name': first_name,
      'last_name': last_name,
      'phone': phone,
      'emergency_contact': emergencyContact,
      'occupation': occupation,
      'email': email,
      'password': password, // Note: Storing passwords in plaintext is not secure
      'profile_picture': profile_picture,
      'sobrietyDate': sobrietyDate?.toIso8601String(),
    };
  }

  // Create a user object from a map (Firestore document)
  factory user.fromMap(Map<String, dynamic> map) {
    return user(
      first_name: map['first_name'] ?? '',
      last_name: map['last_name'] ?? '',
      phone: map['phone'] ?? '',
      emergencyContact: map['emergency_contact'] ?? '',
      occupation: map['occupation'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      profile_picture: map['profile_picture'],
      sobrietyDate: map['sobrietyDate'] != null
          ? DateTime.parse(map['sobrietyDate'])
          : null,
    );
  }

  // Create a user object from a Firestore document snapshot
  factory user.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return user.fromMap(data);
  }
}

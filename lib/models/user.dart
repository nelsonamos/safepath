import 'package:cloud_firestore/cloud_firestore.dart';

class user {
  String first_name;
  String last_name;
  String phone;
  String emergencyContact;
  String obsession;
  String email;
  String password;
  String? profile_picture;
  DateTime? sobrietyDate;
  bool isOnline;

  user({
    required this.first_name,
    required this.last_name,
    required this.phone,
    required this.emergencyContact,
    required this.obsession,
    required this.email,
    required this.password,
    this.profile_picture,
    this.sobrietyDate,
    this.isOnline = false,
  });


  factory user.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    return user(
      first_name: data['first_name'] ?? '',
      last_name: data['last_name'] ?? '',
      phone: data['phone'] ?? '',
      emergencyContact: data['emergencyContact'] ?? '',
      obsession: data['obsession'] ?? '',
      email: data['email'] ?? '',
      password: data['password'] ?? '',
      profile_picture: data['profile_picture'],
      sobrietyDate: data['sobrietyDate'] != null
          ? DateTime.parse(data['sobrietyDate'])
          : null,
      isOnline: data['isOnline'] ?? false, // Default to false if not present
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'first_name': first_name,
      'last_name': last_name,
      'phone': phone,
      'emergencyContact': emergencyContact,
      'obsession': obsession,
      'email': email,
      'password': password,
      'profile_picture': profile_picture,
      'sobrietyDate': sobrietyDate?.toIso8601String(),
      'isOnline': isOnline,
    };
  }
}

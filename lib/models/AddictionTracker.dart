import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// A class to model addiction tracking.
class AddictionTrackers {
  String addiction; // The addiction being tracked
  DateTime? soberStartDate; // The date when the user started being sober
  int usageCount; // The number of times the user has used the substance
  int substanceUsageCount; // Total count of substance usage
  String reasonToStaySober; // The user's personal reason to stay sober
  TimeOfDay? dailyPledgeTime; // Time of the day for the user to take a pledge
  TimeOfDay? dailyReviewTime; // Time of the day for the user to review their progress
  String? email; // The logged-in user's email

  // Constructor with required and optional fields
  AddictionTrackers({
    required this.addiction,
    this.soberStartDate,
    this.usageCount = 0,
    this.substanceUsageCount = 0,
    required this.reasonToStaySober,
    this.dailyPledgeTime,
    this.dailyReviewTime,
    this.email, // Add email as a parameter
  });

  /// Converts an instance of `AddictionTrackers` to a map for storage or transmission.
  Map<String, dynamic> toMap() {
    return {
      'addiction': addiction,
      'soberStartDate': soberStartDate?.toIso8601String(), // ISO format for dates
      'usageCount': usageCount,
      'substanceUsageCount': substanceUsageCount,
      'reasonToStaySober': reasonToStaySober,
      'dailyPledgeTime': dailyPledgeTime != null ? formatTimeOfDay(dailyPledgeTime!) : null,
      'dailyReviewTime': dailyReviewTime != null ? formatTimeOfDay(dailyReviewTime!) : null,
      'email': email, // Add email to the map
    };
  }

  /// Creates an instance of `AddictionTrackers` from a map.
  static AddictionTrackers fromMap(Map<String, dynamic> map) {
    return AddictionTrackers(
      addiction: map['addiction'],
      soberStartDate: map['soberStartDate'] != null ? DateTime.parse(map['soberStartDate']) : null,
      usageCount: map['usageCount'] ?? 0,
      substanceUsageCount: map['substanceUsageCount'] ?? 0,
      reasonToStaySober: map['reasonToStaySober'],
      dailyPledgeTime: parseTimeOfDay(map['dailyPledgeTime']),
      dailyReviewTime: parseTimeOfDay(map['dailyReviewTime']),
      email: map['email'], // Parse email from the map
    );
  }

  /// Formats a `TimeOfDay` instance to a string.
  static String formatTimeOfDay(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    final format = DateFormat("HH:mm"); // "HH:mm" for 24-hour time format
    return format.format(dt);
  }

  /// Parses a string to a `TimeOfDay` instance.
  static TimeOfDay? parseTimeOfDay(String? time) {
    if (time == null || time.isEmpty) return null;
    final format = DateFormat.Hm(); // "HH:mm" for 24-hour time format
    final dt = format.parse(time);
    return TimeOfDay(hour: dt.hour, minute: dt.minute);
  }
}

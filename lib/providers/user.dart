import 'package:gui_flutter/models/car_stats.dart';
import 'package:gui_flutter/models/emergency_contacts.dart';
import 'package:gui_flutter/models/options.dart';
import 'package:gui_flutter/models/personal_info.dart';

class UserData {
  String vin;
  PersonalInfo personalInfo;
  CarStats carStats;
  EmergencyContacts emergencyContacts;
  Options options;

  UserData({
    required this.vin,
    required this.personalInfo,
    required this.carStats,
    required this.emergencyContacts,
    required this.options,
  });

  Map<String, dynamic> toJson() => {
    'vin': vin,
    'personalInfo': personalInfo.toJson(),
    'carStats': carStats.toJson(),
    'emergencyContacts': emergencyContacts.toJson(),
    'options': options.toJson(),
  };

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      vin: json['vin'],
      personalInfo: PersonalInfo.fromJson(json['personalInfo']),
      carStats: CarStats.fromJson(json['carStats']),
      emergencyContacts: EmergencyContacts.fromJson(json['emergencyContacts']),
      options: Options.fromJson(json['options']),
    );
  }
}

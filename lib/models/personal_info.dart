import 'package:gui_flutter/models/adress.dart';

class PersonalInfo {
  String name;
  Address address;
  String bloodType;
  String insurance;

  PersonalInfo({
    required this.name,
    required this.address,
    required this.bloodType,
    required this.insurance,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'address': address.toJson(),
    'bloodType': bloodType,
    'insurance': insurance,
  };

  factory PersonalInfo.fromJson(Map<String, dynamic> json) {
    return PersonalInfo(
      name: json['name'],
      address: Address.fromJson(json['address']),
      bloodType: json['bloodType'],
      insurance: json['insurance'],
    );
  }
}

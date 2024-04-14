import 'package:gui_flutter/models/adress.dart';

class PersonalInfo {
  String name;
  Address address;
  String bloodGroup;
  String insuranceCompany;

  PersonalInfo({
    required this.name,
    required this.address,
    required this.bloodGroup,
    required this.insuranceCompany,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'address': address.toJson(),
    'bloodType': bloodGroup,
    'insurance': insuranceCompany,
  };

  factory PersonalInfo.fromJson(Map<String, dynamic> json) {
    return PersonalInfo(
      name: json['name'],
      address: Address.fromJson(json['address']),
      bloodGroup: json['bloodType'],
      insuranceCompany: json['insurance'],
    );
  }
}

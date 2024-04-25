import 'package:gui_flutter/models/adress.dart';

class PersonalInfo {
  String name;
  String address;
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
    'address': address,
    'bloodType': bloodGroup,
    'insurance_company': insuranceCompany,
  };

  factory PersonalInfo.fromJson(Map<String, dynamic> json) {
    return PersonalInfo(
      name: json['name'] ?? "",
      address: json['address'] ?? "",
      bloodGroup: json['bloodType'] ?? "",
      insuranceCompany: json['insurance_company'] ?? "",
    );
  }
}

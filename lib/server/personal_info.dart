import 'package:gui_flutter/models/adress.dart';
import 'package:gui_flutter/models/personal_info.dart';

class PersonalInfoApi {

  Future<PersonalInfo> fetchPersonalInfo() async {
    // Implement the API call to fetch personal info
    return PersonalInfo(name: "Rudolf", address: Address(street: "Strurova", city: "Smolenice", zipCode: "91904", country: "SK"), bloodGroup: "B", insuranceCompany: "VSZP");
  }

  Future<void> updatePersonalInfo(PersonalInfo personalInfo) async {
    // Implement the API call to update personal info
  }
}

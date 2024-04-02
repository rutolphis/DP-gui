import 'package:gui_flutter/models/contact.dart';

class EmergencyContactsApi {
  Future<List<Contact>> fetchEmergencyContacts() async {
    return [
      Contact(name: "mama", phone: "09092221"),
      Contact(name: "tato", phone: "09092221"),
      Contact(name: "nikolas", phone: "09092221")
    ];
    // Implement your API fetching logic here
  }

  Future<void> updateEmergencyContacts(List<Contact> contacts) async {
    // Implement your API update logic here
  }
}

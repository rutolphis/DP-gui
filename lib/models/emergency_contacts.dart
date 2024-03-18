import 'package:gui_flutter/models/contact.dart';

class EmergencyContacts {
  List<Contact> contacts;

  EmergencyContacts({required this.contacts});

  Map<String, dynamic> toJson() => {
    'contacts': contacts.map((contact) => contact.toJson()).toList(),
  };

  factory EmergencyContacts.fromJson(Map<String, dynamic> json) {
    var contactList = json['contacts'] as List;
    List<Contact> contacts = contactList.map((i) => Contact.fromJson(i)).toList();
    return EmergencyContacts(contacts: contacts);
  }
}

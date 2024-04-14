import 'package:gui_flutter/models/contact.dart';

abstract class EmergencyContactsEvent {}

class LoadEmergencyContacts extends EmergencyContactsEvent {}

class AddEmergencyContact extends EmergencyContactsEvent {
  final Contact contact;

  AddEmergencyContact(this.contact);
}

class UpdateEmergencyContact extends EmergencyContactsEvent {
  final int index;
  final Contact updatedContact;

  UpdateEmergencyContact(this.index, this.updatedContact);
}

class DeleteEmergencyContact extends EmergencyContactsEvent {
  final int index;

  DeleteEmergencyContact(this.index);
}

class UpdateEmergencyContacts extends EmergencyContactsEvent {
  final List<Contact> newContacts;

  UpdateEmergencyContacts(this.newContacts);
}

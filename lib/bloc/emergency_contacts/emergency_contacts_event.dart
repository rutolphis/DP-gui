import 'package:gui_flutter/models/contact.dart';

abstract class EmergencyContactsEvent {}

class LoadEmergencyContacts extends EmergencyContactsEvent {
  final String vin;

  LoadEmergencyContacts(this.vin);
}

class AddEmergencyContact extends EmergencyContactsEvent {
  final String vin;
  final Contact contact;

  AddEmergencyContact(this.contact, this.vin);
}

class UpdateEmergencyContact extends EmergencyContactsEvent {
  final String vin;
  final int index;
  final Contact updatedContact;

  UpdateEmergencyContact(this.index, this.updatedContact, this.vin);
}

class DeleteEmergencyContact extends EmergencyContactsEvent {
  final String vin;
  final int index;

  DeleteEmergencyContact(this.index, this.vin);
}


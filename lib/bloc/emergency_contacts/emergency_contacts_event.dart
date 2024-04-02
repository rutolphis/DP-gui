import 'package:gui_flutter/models/contact.dart';

abstract class EmergencyContactsEvent {}

class LoadEmergencyContacts extends EmergencyContactsEvent {}

class UpdateEmergencyContacts extends EmergencyContactsEvent {
  final List<Contact> newContacts;

  UpdateEmergencyContacts(this.newContacts);
}

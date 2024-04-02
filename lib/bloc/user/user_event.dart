// Extending UserEvent to include emergency contact actions
import '../../models/emergency_contacts.dart';

abstract class UserEvent {}

class LoadUser extends UserEvent {}

class UpdateEmergencyContacts extends UserEvent {
  final EmergencyContacts updatedContact;
  UpdateEmergencyContacts(this.updatedContact);
}


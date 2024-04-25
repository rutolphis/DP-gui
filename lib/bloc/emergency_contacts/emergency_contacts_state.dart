import 'package:gui_flutter/models/contact.dart';

abstract class EmergencyContactsState {}

class EmergencyContactsInitial extends EmergencyContactsState {}

class EmergencyContactsLoading extends EmergencyContactsState {}

class EmergencyContactsLoaded extends EmergencyContactsState {
  final String vin;
  final List<Contact> contacts;

  EmergencyContactsLoaded(this.contacts, this.vin);
}

class EmergencyContactsError extends EmergencyContactsState {
  final String message;

  EmergencyContactsError(this.message);
}
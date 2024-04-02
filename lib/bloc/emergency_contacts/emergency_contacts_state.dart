import 'package:gui_flutter/models/contact.dart';

abstract class EmergencyContactsState {}

class EmergencyContactsInitial extends EmergencyContactsState {}

class EmergencyContactsLoading extends EmergencyContactsState {}

class EmergencyContactsLoaded extends EmergencyContactsState {
  final List<Contact> contacts;

  EmergencyContactsLoaded(this.contacts);
}

class EmergencyContactsError extends EmergencyContactsState {
  final String message;

  EmergencyContactsError(this.message);
}
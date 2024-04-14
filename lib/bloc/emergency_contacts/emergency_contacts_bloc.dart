import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gui_flutter/bloc/emergency_contacts/emergency_contacts_event.dart';
import 'package:gui_flutter/bloc/emergency_contacts/emergency_contacts_state.dart';
import 'package:gui_flutter/models/contact.dart';
import 'package:gui_flutter/server/emergency_contacts.dart';

class EmergencyContactsBloc extends Bloc<EmergencyContactsEvent, EmergencyContactsState> {
  final EmergencyContactsApi repository = EmergencyContactsApi();

  EmergencyContactsBloc() : super(EmergencyContactsInitial()) {
    on<LoadEmergencyContacts>(_onLoadEmergencyContacts);
    on<AddEmergencyContact>(_onAddEmergencyContact);
    on<UpdateEmergencyContact>(_onUpdateEmergencyContact);
    on<DeleteEmergencyContact>(_onDeleteEmergencyContact);
    on<UpdateEmergencyContacts>(_onUpdateEmergencyContacts);
  }

  Future<void> _onLoadEmergencyContacts(
      LoadEmergencyContacts event,
      Emitter<EmergencyContactsState> emit,
      ) async {
    emit(EmergencyContactsLoading());
    try {
      final contacts = await repository.fetchEmergencyContacts();
      emit(EmergencyContactsLoaded(contacts));
    } catch (e) {
      emit(EmergencyContactsError(e.toString()));
    }
  }

  void _onAddEmergencyContact(
      AddEmergencyContact event,
      Emitter<EmergencyContactsState> emit,
      ) {
    if (state is EmergencyContactsLoaded) {
      final loadedState = state as EmergencyContactsLoaded;
      final updatedContacts = List<Contact>.from(loadedState.contacts)..add(event.contact);
      emit(EmergencyContactsLoaded(updatedContacts));
    }
  }

  void _onUpdateEmergencyContact(
      UpdateEmergencyContact event,
      Emitter<EmergencyContactsState> emit,
      ) {
    if (state is EmergencyContactsLoaded) {
      final loadedState = state as EmergencyContactsLoaded;
      final updatedContacts = List<Contact>.from(loadedState.contacts);
      updatedContacts[event.index] = event.updatedContact;
      emit(EmergencyContactsLoaded(updatedContacts));
    }
  }

  void _onDeleteEmergencyContact(
      DeleteEmergencyContact event,
      Emitter<EmergencyContactsState> emit,
      ) {
    if (state is EmergencyContactsLoaded) {
      final loadedState = state as EmergencyContactsLoaded;
      final updatedContacts = List<Contact>.from(loadedState.contacts)..removeAt(event.index);
      emit(EmergencyContactsLoaded(updatedContacts));
    }
  }

  Future<void> _onUpdateEmergencyContacts(
      UpdateEmergencyContacts event,
      Emitter<EmergencyContactsState> emit,
      ) async {
    emit(EmergencyContactsLoading());
    try {
      await repository.updateEmergencyContacts(event.newContacts);
      emit(EmergencyContactsLoaded(event.newContacts));
    } catch (e) {
      emit(EmergencyContactsError(e.toString()));
    }
  }
}


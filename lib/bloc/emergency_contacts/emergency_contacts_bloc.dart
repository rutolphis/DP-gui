import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gui_flutter/bloc/emergency_contacts/emergency_contacts_event.dart';
import 'package:gui_flutter/bloc/emergency_contacts/emergency_contacts_state.dart';
import 'package:gui_flutter/models/contact.dart';
import 'package:gui_flutter/server/emergency_contacts.dart';

class EmergencyContactsBloc
    extends Bloc<EmergencyContactsEvent, EmergencyContactsState> {
  final EmergencyContactsApi repository = EmergencyContactsApi();

  EmergencyContactsBloc() : super(EmergencyContactsInitial()) {
    on<LoadEmergencyContacts>(_onLoadEmergencyContacts);
    on<AddEmergencyContact>(_onAddEmergencyContact);
    on<UpdateEmergencyContact>(_onUpdateEmergencyContact);
    on<DeleteEmergencyContact>(_onDeleteEmergencyContact);
  }

  Future<void> _onLoadEmergencyContacts(
    LoadEmergencyContacts event,
    Emitter<EmergencyContactsState> emit,
  ) async {
    emit(EmergencyContactsLoading());
    try {
      final contacts = await repository.fetchEmergencyContacts(event.vin) ?? [];
      emit(EmergencyContactsLoaded(contacts, event.vin));
    } catch (e) {
      emit(EmergencyContactsError(e.toString()));
    }
  }

  Future<void> _onAddEmergencyContact(
    AddEmergencyContact event,
    Emitter<EmergencyContactsState> emit,
  ) async {
    if (state is EmergencyContactsLoaded) {
      final loadedState = state as EmergencyContactsLoaded;
      emit(EmergencyContactsLoading());
      final updatedContacts = List<Contact>.from(loadedState.contacts)
        ..add(event.contact);
      try {
        await repository.updateEmergencyContacts(event.vin, updatedContacts);
        emit(EmergencyContactsLoaded(updatedContacts, event.vin));
      } catch (e) {
        emit(EmergencyContactsError(e.toString()));
      }
    }
  }

  Future<void> _onUpdateEmergencyContact(
    UpdateEmergencyContact event,
    Emitter<EmergencyContactsState> emit,
  ) async {
    if (state is EmergencyContactsLoaded) {
      final loadedState = state as EmergencyContactsLoaded;
      emit(EmergencyContactsLoading());
      final updatedContacts = List<Contact>.from(loadedState.contacts);
      updatedContacts[event.index] = event.updatedContact;
      try {
        await repository.updateEmergencyContacts(event.vin, updatedContacts);
        emit(EmergencyContactsLoaded(updatedContacts,event.vin));
      } catch (e) {
        emit(EmergencyContactsError(e.toString()));
      }
    }
  }

  Future<void> _onDeleteEmergencyContact(
    DeleteEmergencyContact event,
    Emitter<EmergencyContactsState> emit,
  ) async {
    if (state is EmergencyContactsLoaded) {
      final loadedState = state as EmergencyContactsLoaded;
      emit(EmergencyContactsLoading());
      final updatedContacts = List<Contact>.from(loadedState.contacts)
        ..removeAt(event.index);
      try {
        await repository.updateEmergencyContacts(event.vin, updatedContacts);
        emit(EmergencyContactsLoaded(updatedContacts, event.vin));
      } catch (e) {
        emit(EmergencyContactsError(e.toString()));
      }
    }
  }
}

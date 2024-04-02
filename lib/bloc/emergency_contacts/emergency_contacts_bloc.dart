import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gui_flutter/bloc/emergency_contacts/emergency_contacts_event.dart';
import 'package:gui_flutter/bloc/emergency_contacts/emergency_contacts_state.dart';
import 'package:gui_flutter/server/emergency_contacts.dart';

class EmergencyContactsBloc
    extends Bloc<EmergencyContactsEvent, EmergencyContactsState> {
  final EmergencyContactsApi repository = EmergencyContactsApi();

  EmergencyContactsBloc() : super(EmergencyContactsInitial()) {
    on<LoadEmergencyContacts>(_onLoadEmergencyContacts);
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

  Future<void> _onUpdateEmergencyContacts(
    UpdateEmergencyContacts event,
    Emitter<EmergencyContactsState> emit,
  ) async {
    emit(EmergencyContactsLoading());
    try {
      await repository.updateEmergencyContacts(event.newContacts);
      // After updating, you might want to reload the contacts
      final contacts = event.newContacts;
      emit(EmergencyContactsLoaded(contacts));
    } catch (e) {
      emit(EmergencyContactsError(e.toString()));
    }
  }
}

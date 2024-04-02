import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gui_flutter/bloc/user/user_event.dart';
import 'package:gui_flutter/bloc/user/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserLoading()) {
    on<LoadUser>(_onLoadUser);
    on<UpdateEmergencyContacts>(_onUpdateEmergencyContacts);
  }

  void _onLoadUser(LoadUser event, Emitter<UserState> emit) {
    // Implementation to load user data
  }

  void _onUpdateEmergencyContacts(UpdateEmergencyContacts event, Emitter<UserState> emit) {
    if (state is UserLoaded) {
      final currentState = state as UserLoaded;
      // Update the entire list of emergency contacts
      emit(UserLoaded(currentState.user.copyWith(emergencyContacts: event.contacts)));
    } else {
      // Handle cases where there might not be a loaded user yet
      emit(UserError("No user loaded"));
    }
  }
}

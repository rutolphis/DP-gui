import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gui_flutter/bloc/personal_info/personal_info_event.dart';
import 'package:gui_flutter/bloc/personal_info/personal_info_state.dart';
import 'package:gui_flutter/server/personal_info.dart';

class PersonalInfoBloc extends Bloc<PersonalInfoEvent, PersonalInfoState> {
  final PersonalInfoApi repository = PersonalInfoApi();

  PersonalInfoBloc() : super(PersonalInfoInitial()) {
    on<LoadPersonalInfo>(_onLoadPersonalInfo);
    on<UpdatePersonalInfo>(_onUpdatePersonalInfo);
  }

  Future<void> _onLoadPersonalInfo(
    LoadPersonalInfo event,
    Emitter<PersonalInfoState> emit,
  ) async {
    emit(PersonalInfoLoading());
    try {
      final personalInfo = await repository.fetchPersonalInfo(event.vin);
      emit(PersonalInfoLoaded(personalInfo!, event.vin));
    } catch (e) {
      emit(PersonalInfoError(e.toString()));
    }
  }

  Future<void> _onUpdatePersonalInfo(
    UpdatePersonalInfo event,
    Emitter<PersonalInfoState> emit,
  ) async {
    if (state is PersonalInfoLoaded) {
      final loadedState = state as PersonalInfoLoaded;
      emit(PersonalInfoLoading());
      try {
        await repository.updatePersonalInfo(
            event.personalInfo, loadedState.vin);
        emit(PersonalInfoLoaded(event.personalInfo, loadedState.vin));
      } catch (e) {
        emit(PersonalInfoError(e.toString()));
      }
    }
  }
}

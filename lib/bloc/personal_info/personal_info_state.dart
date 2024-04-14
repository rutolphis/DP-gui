import 'package:gui_flutter/models/personal_info.dart';

abstract class PersonalInfoState {}

class PersonalInfoInitial extends PersonalInfoState {}

class PersonalInfoLoading extends PersonalInfoState {}

class PersonalInfoLoaded extends PersonalInfoState {
  final PersonalInfo personalInfo;

  PersonalInfoLoaded(this.personalInfo);
}

class PersonalInfoError extends PersonalInfoState {
  final String message;

  PersonalInfoError(this.message);
}

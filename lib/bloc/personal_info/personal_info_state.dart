import 'package:gui_flutter/models/personal_info.dart';

abstract class PersonalInfoState {}

class PersonalInfoInitial extends PersonalInfoState {}

class PersonalInfoLoading extends PersonalInfoState {}

class PersonalInfoLoaded extends PersonalInfoState {
  final PersonalInfo personalInfo;
  final String vin;

  PersonalInfoLoaded(this.personalInfo, this.vin);
}

class PersonalInfoError extends PersonalInfoState {
  final String message;

  PersonalInfoError(this.message);
}

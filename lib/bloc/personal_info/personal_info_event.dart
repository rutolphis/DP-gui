import '../../models/personal_info.dart';

abstract class PersonalInfoEvent {}

class LoadPersonalInfo extends PersonalInfoEvent {
  final String vin;

  LoadPersonalInfo(this.vin);
}

class UpdatePersonalInfo extends PersonalInfoEvent {
  final PersonalInfo personalInfo;

  UpdatePersonalInfo(this.personalInfo);
}

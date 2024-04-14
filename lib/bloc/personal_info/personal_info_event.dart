import '../../models/personal_info.dart';

abstract class PersonalInfoEvent {}

class LoadPersonalInfo extends PersonalInfoEvent {}

class UpdatePersonalInfo extends PersonalInfoEvent {
  final PersonalInfo personalInfo;

  UpdatePersonalInfo(this.personalInfo);
}

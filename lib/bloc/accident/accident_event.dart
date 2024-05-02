abstract class AccidentEvent {}

class AccidentDetected extends AccidentEvent {
}

class UserResponseToAccident extends AccidentEvent {
  final bool userConfirmed;
  UserResponseToAccident(this.userConfirmed);
}

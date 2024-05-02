abstract class AccidentState {}

class AccidentInitialState extends AccidentState {}

class AccidentNotificationReceived extends AccidentState {
}

class AccidentUserConfirmed extends AccidentState {}

class AccidentUserDenied extends AccidentState {}

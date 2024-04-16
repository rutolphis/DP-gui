abstract class SocketEvent {}

class ConnectSocket extends SocketEvent {}

class ConnectedSocket extends SocketEvent {}

class DisconnectSocket extends SocketEvent {}

class RequestInitialization extends SocketEvent {}

class ScanBLE extends SocketEvent {}

class ReceiveInitialization extends SocketEvent {
  final String vin;
  ReceiveInitialization(this.vin);
}

class ScanCompleted extends SocketEvent {
  final Map<String, dynamic> data;
  ScanCompleted(this.data);
}

class ScanError extends SocketEvent {
  final String message;
  ScanError(this.message);
}

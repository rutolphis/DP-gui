abstract class SocketState {}

class SocketInitial extends SocketState {}

class SocketConnected extends SocketState {}

class SocketDisconnected extends SocketState {}

class SocketInitialized extends SocketState {
  final String vin;
  SocketInitialized(this.vin);
}

class SocketScanCompleted extends SocketState {
  final Map<String, dynamic> data;
  SocketScanCompleted(this.data);
}

class SocketScanError extends SocketState {
  final String message;
  SocketScanError(this.message);
}
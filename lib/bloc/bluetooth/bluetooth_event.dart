abstract class BluetoothEvent {}

class BluetoothScanCompleted extends BluetoothEvent {
  final dynamic data;
  BluetoothScanCompleted(this.data);
}

class BluetoothScanError extends BluetoothEvent {
  final String error;
  BluetoothScanError(this.error);
}

class ConnectDevice extends BluetoothEvent {
  final String address;
  final String authKey;
  ConnectDevice(this.address, this.authKey);
}

class ConnectedDevice extends BluetoothEvent {
  final String name;
  ConnectedDevice(this.name);
}

class BluetoothScan extends BluetoothEvent {}

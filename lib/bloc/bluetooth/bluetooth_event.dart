import 'package:gui_flutter/models/bluetooth_device.dart';

abstract class BluetoothEvent {}

class BluetoothScanCompleted extends BluetoothEvent {
  final dynamic data;

  BluetoothScanCompleted(this.data);
}

class CheckDevicesStatus extends BluetoothEvent {
}


class BluetoothScanError extends BluetoothEvent {
  final String error;

  BluetoothScanError(this.error);
}

class ConnectDevice extends BluetoothEvent {
  final BluetoothDevice device;
  final String authKey;

  ConnectDevice(this.device, this.authKey);
}

class ConnectionError extends BluetoothEvent {}

class ConnectedDevice extends BluetoothEvent {
  final BluetoothDevice device;

  ConnectedDevice(this.device);
}

class DisconnectDevice extends BluetoothEvent {
  final BluetoothDevice device;

  DisconnectDevice(this.device);
}

class BluetoothScan extends BluetoothEvent {}

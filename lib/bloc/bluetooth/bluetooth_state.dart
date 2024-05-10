import 'package:gui_flutter/models/bluetooth_device.dart';

abstract class BluetoothState {}

class NoConnectedDevices extends BluetoothState {}

class ConnectedDevices extends BluetoothState {
  final List<BluetoothDevice> devices;

  ConnectedDevices(this.devices);
}

class BluetoothError extends BluetoothState {
  final String error;

  BluetoothError(this.error);
}

import 'package:gui_flutter/models/bluetooth_device.dart';

abstract class BluetoothState {}

class NoConnectedDevices extends BluetoothState {}

class ConnectedDevices extends BluetoothState {
  final List<BluetoothDevice> devices;

  ConnectedDevices(this.devices);
}

class BluetoothDataReceived extends BluetoothState {
  final List<BluetoothDevice?> data;

  BluetoothDataReceived(this.data);
}

class DevicesUpdated extends BluetoothState {
  // State when there is at least one connected device
  final List<BluetoothDevice> devices;

  DevicesUpdated(this.devices);
}

class DeviceConnecting extends BluetoothState {
  DeviceConnecting();
}

class BluetoothScanning extends BluetoothState {}

class BluetoothError extends BluetoothState {
  final String error;

  BluetoothError(this.error);
}

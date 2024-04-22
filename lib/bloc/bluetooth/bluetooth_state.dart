import 'package:gui_flutter/models/bluetooth_device.dart';

abstract class BluetoothState {}

class BluetoothInitial extends BluetoothState {}

class BluetoothDataReceived extends BluetoothState {
  final List<BluetoothDevice?> data;
  BluetoothDataReceived(this.data);
}


class DeviceConnected extends BluetoothState {
  final String name;
  DeviceConnected(this.name);
}

class DeviceConnecting extends BluetoothState {
  DeviceConnecting();
}


class BluetoothScanning extends BluetoothState {}

class BluetoothError extends BluetoothState {
  final String error;
  BluetoothError(this.error);
}
import 'package:gui_flutter/models/bluetooth_device.dart';

abstract class BluetoothConnectState {}

class BluetoothConnectInitial extends BluetoothConnectState {}

class BluetoothConnectDataReceived extends BluetoothConnectState {
  final List<BluetoothDevice?> data;

  BluetoothConnectDataReceived(this.data);
}

class BluetoothConnectDeviceSuccess extends BluetoothConnectState {
  // State when there is at least one connected device
  final BluetoothDevice device;

  BluetoothConnectDeviceSuccess(this.device);
}

class BluetoothDeviceConnecting extends BluetoothConnectState {}

class BluetoothDeviceScanning extends BluetoothConnectState {}

class BluetoothConnectError extends BluetoothConnectState {}

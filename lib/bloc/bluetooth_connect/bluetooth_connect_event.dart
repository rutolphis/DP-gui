import 'package:gui_flutter/models/bluetooth_device.dart';

abstract class BluetoothConnectEvent {}


class BluetoothScanCompleted extends BluetoothConnectEvent {
  final dynamic data;

  BluetoothScanCompleted(this.data);
}

class CheckDevicesStatus extends BluetoothConnectEvent {
}


class BluetoothScanError extends BluetoothConnectEvent {
  final String? error;

  BluetoothScanError(this.error);
}

class ConnectDevice extends BluetoothConnectEvent {
  final BluetoothDevice device;
  final String authKey;
  final bool isDriver;

  ConnectDevice(this.device, this.authKey, this.isDriver);
}

class ConnectDeviceSuccess extends BluetoothConnectEvent {
  final BluetoothDevice device;

  ConnectDeviceSuccess(this.device,);
}

class ConnectionError extends BluetoothConnectEvent {}


class DisconnectDevice extends BluetoothConnectEvent {
  final String address;

  DisconnectDevice(this.address);
}

class BluetoothScan extends BluetoothConnectEvent {}

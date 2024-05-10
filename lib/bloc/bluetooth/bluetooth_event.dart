import 'package:gui_flutter/models/bluetooth_device.dart';

abstract class BluetoothEvent {}

class ConnectedDevice extends BluetoothEvent {
  final BluetoothDevice device;

  ConnectedDevice(this.device);
}

class DisconnectedDevice extends BluetoothEvent {
  final String address;

  DisconnectedDevice(this.address);
}

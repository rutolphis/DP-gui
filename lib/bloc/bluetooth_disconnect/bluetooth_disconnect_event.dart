// Abstract base event class
import 'package:gui_flutter/models/bluetooth_device.dart';

abstract class BluetoothDisconnectionEvent {
  const BluetoothDisconnectionEvent();
}

class DisconnectRequest extends BluetoothDisconnectionEvent {
  final String address;

  const DisconnectRequest(this.address);
}

class DisconnectedDevice extends BluetoothDisconnectionEvent {
  final String address;

  const DisconnectedDevice(this.address);
}

class ErrorDisconnectingDevice extends BluetoothDisconnectionEvent {
  final String error;

  const ErrorDisconnectingDevice(this.error);
}

// Abstract base state class
import 'package:gui_flutter/models/bluetooth_device.dart';

abstract class BluetoothDisconnectionState {
  const BluetoothDisconnectionState();
}

class DisconnectionInitial extends BluetoothDisconnectionState {
  @override
  bool operator ==(Object other) => identical(this, other) || other is DisconnectionInitial;

  @override
  int get hashCode => 0;
}

class DeviceDisconnecting extends BluetoothDisconnectionState {
  @override
  bool operator ==(Object other) => identical(this, other) || other is DeviceDisconnecting;

  @override
  int get hashCode => 0;
}

class DeviceDisconnected extends BluetoothDisconnectionState {
  final String address;

  const DeviceDisconnected(this.address);

}

class DisconnectionError extends BluetoothDisconnectionState {
  final String error;

  const DisconnectionError(this.error);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is DisconnectionError &&
              runtimeType == other.runtimeType &&
              error == other.error;

  @override
  int get hashCode => error.hashCode;
}
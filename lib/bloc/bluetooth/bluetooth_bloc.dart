import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gui_flutter/bloc/socket/socket_bloc.dart';
import 'package:gui_flutter/models/bluetooth_device.dart';
import 'package:gui_flutter/models/vehicle_data.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'bluetooth_event.dart';
import 'bluetooth_state.dart';

class BluetoothBloc extends Bloc<BluetoothEvent, BluetoothState> {
  final List<BluetoothDevice> connectedDevices =
      []; // List to track connected devices

  BluetoothBloc() : super(NoConnectedDevices()) {
    on<ConnectedDevice>(_onConnectedDevice);
    on<DisconnectedDevice>(_onDisconnectedDevice);
  }

  List<BluetoothDevice?> handleDevicesData(String jsonData) {
    var decoded = json.decode(jsonData);
    List<BluetoothDevice> devices = (decoded['results'] as List)
        .map((item) => BluetoothDevice.fromJson(item as Map<String, dynamic>))
        .toList();
    return devices;
  }

  // Method to handle device connection
  void _onConnectedDevice(ConnectedDevice event, Emitter<BluetoothState> emit) {
    // Modify according to actual model
    if (!connectedDevices
        .any((device) => device.address == event.device.address)) {
      // Add the device only if it's not already in the list
      connectedDevices.add(event.device);
    }
    if (connectedDevices.isNotEmpty) {
      emit(ConnectedDevices(connectedDevices));
    } else {
      emit(NoConnectedDevices());
    }
  }

  // Method to handle device disconnection
  void _onDisconnectedDevice(
      DisconnectedDevice event, Emitter<BluetoothState> emit) {
    connectedDevices.removeWhere((device) => device.address == event.address);
    if (connectedDevices.isEmpty) {
      emit(
          NoConnectedDevices()); // Emit state indicating no devices are connected
    } else {
      emit(ConnectedDevices(connectedDevices)); // Update state with current list
    }
  }

}

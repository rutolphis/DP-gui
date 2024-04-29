import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gui_flutter/bloc/socket/socket_bloc.dart';
import 'package:gui_flutter/models/bluetooth_device.dart';
import 'package:gui_flutter/models/vehicle_data.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'bluetooth_event.dart';
import 'bluetooth_state.dart';

class BluetoothBloc extends Bloc<BluetoothEvent, BluetoothState> {
  final SocketBloc socketBloc;
  late final IO.Socket socket;
  final List<BluetoothDevice> connectedDevices = [];  // List to track connected devices


  BluetoothBloc({required this.socketBloc}) : super(NoConnectedDevices()) {
    socket = socketBloc.socket;

    if (socket.connected) {
      print("ble conneceted");
    } else {
      print("ble not connecetd");
    }

    // Listen to the socket events directly
    socket.on('scan_completed', (data) {
      print('Scan completed with data: $data');
      add(BluetoothScanCompleted(json.encode(data)));  // Assuming you have a ScanCompleted event in your Bloc
    });

    socket.on('scan_error', (data) {
      print('Scan error with message: $data');
      add(BluetoothScanError(data['error']));  // Assuming you have a ScanError event in your Bloc
    });

    socket.on('connection_error', (data) {
      print('Connect error with message: $data');
      add(ConnectionError());  // Assuming you have a ScanError event in your Bloc
    });

    socket.on('connection_success', (data) {
      print('Connect success with message: $data');
      add(ConnectedDevice(BluetoothDevice(name: data['name'], address: data['device_address'])));  // Assuming you have a ScanError event in your Bloc
    });

    on<BluetoothScan>(_onScanBLE);
    on<BluetoothScanCompleted>(_onScanCompleted);  // Handle scan completed
    on<BluetoothScanError>(_onScanError);
    on<ConnectDevice>(_onConnectDevice);
    on<ConnectionError>(_onConnectionError);
    on<ConnectedDevice>(_onConnectedDevice);
    on<DisconnectDevice>(_onDisconnectDevice);
    on<CheckDevicesStatus>(_onCheckDevicesStatus);

  }

  void _onScanBLE(BluetoothScan event, Emitter<BluetoothState> emit) {
      socket.emit('scan_ble');
      emit(BluetoothScanning());
      print('BLE scan requested');
  }

  void _onScanCompleted(BluetoothScanCompleted event, Emitter<BluetoothState> emit) {
    List<BluetoothDevice?> dataParsed = handleDevicesData(event.data);
    if(state is! NoConnectedDevices || state is! ConnectedDevices) {
      emit(BluetoothDataReceived(dataParsed));
    }
  }

  void _onScanError(BluetoothScanError event, Emitter<BluetoothState> emit) {
    emit(BluetoothError(event.error));  // Update state with error message
  }

  List<BluetoothDevice?> handleDevicesData(String jsonData) {
    var decoded = json.decode(jsonData);
    List<BluetoothDevice> devices = (decoded['results'] as List)
        .map((item) => BluetoothDevice.fromJson(item as Map<String, dynamic>))
        .toList();
    return devices;
  }

  void _onConnectDevice(ConnectDevice event, Emitter<BluetoothState> emit) {
    socket.emit('connect_miband', {'device_address': event.device.address, 'name': event.device.name, 'auth_key': event.authKey});
    emit(DeviceConnecting());
  }

  void _onConnectionError(ConnectionError event, Emitter<BluetoothState> emit) {
    if(state is! NoConnectedDevices || state is! ConnectedDevices) {
      emit(NoConnectedDevices());
    }
  }

  // Method to handle device connection
  void _onConnectedDevice(ConnectedDevice event, Emitter<BluetoothState> emit) {
    var device = event.device;  // Modify according to actual model
    connectedDevices.add(device);
    emit(DevicesUpdated(connectedDevices));  // Emit state with updated device list
  }

  // Method to handle device disconnection
  void _onDisconnectDevice(DisconnectDevice event, Emitter<BluetoothState> emit) {
    connectedDevices.removeWhere((device) => device.address == event.device.address);
    if (connectedDevices.isEmpty) {
      emit(NoConnectedDevices());  // Emit state indicating no devices are connected
    } else {
      emit(DevicesUpdated(connectedDevices));  // Update state with current list
    }
  }

  void _onCheckDevicesStatus(CheckDevicesStatus event, Emitter<BluetoothState> emit) {
    if (connectedDevices.isEmpty) {
      emit(NoConnectedDevices());  // Emit state indicating no devices are connected
    } else {
      emit(ConnectedDevices(connectedDevices));  // Update state with current list
    }
  }


  @override
  Future<void> close() {
    socket.off('connection_success');
    socket.off('scan_completed');
    socket.off('scan_error');
    return super.close();
  }
}

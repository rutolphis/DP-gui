import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gui_flutter/bloc/bluetooth/bluetooth_bloc.dart';
import 'package:gui_flutter/bloc/socket/socket_bloc.dart';
import 'package:gui_flutter/models/bluetooth_device.dart';
import 'package:gui_flutter/models/vehicle_data.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'bluetooth_connect_event.dart';
import 'bluetooth_connect_state.dart';
import 'package:gui_flutter/bloc/bluetooth/bluetooth_event.dart';

class BluetoothConnectBloc
    extends Bloc<BluetoothConnectEvent, BluetoothConnectState> {
  final SocketBloc socketBloc;
  final BluetoothBloc bluetoothBloc;
  late final IO.Socket socket;
  final List<BluetoothDevice> connectedDevices =
      []; // List to track connected devices

  BluetoothConnectBloc({required this.socketBloc, required this.bluetoothBloc})
      : super(BluetoothConnectInitial()) {
    socket = socketBloc.socket;

    if (socket.connected) {
      print("ble conneceted");
    } else {
      print("ble not connecetd");
    }

    // Listen to the socket events directly
    socket.on('scan_completed', (data) {
      print('Scan completed with data: $data');
      add(BluetoothScanCompleted(json.encode(
          data))); // Assuming you have a ScanCompleted event in your Bloc
    });

    socket.on('scan_error', (data) {
      print('Scan error with message: $data');
      add(BluetoothScanError(
          data['error'])); // Assuming you have a ScanError event in your Bloc
    });

    socket.on('connection_error', (data) {
      print('Connect error with message: $data');
      add(ConnectionError()); // Assuming you have a ScanError event in your Bloc
    });

    socket.on('connection_success', (data) {
      print('Connect success with message: $data');
      BluetoothDevice connectedDevice = BluetoothDevice(
          name: data['name'],
          address: data[
          'device_address']);
      bluetoothBloc.add(ConnectedDevice(connectedDevice));
      add(ConnectDeviceSuccess(connectedDevice));
    });

    on<BluetoothScan>(_onScanBLE);
    on<BluetoothScanCompleted>(_onScanCompleted); // Handle scan completed
    on<BluetoothScanError>(_onScanError);
    on<ConnectDevice>(_onConnectDevice);
    on<ConnectionError>(_onConnectionError);
    on<ConnectDeviceSuccess>(_onConnectDeviceSuccess);
  }

  void _onScanBLE(BluetoothScan event, Emitter<BluetoothConnectState> emit) {
    socket.emit('scan_ble');
    emit(BluetoothDeviceScanning());
    print('BLE scan requested');
  }

  void _onScanCompleted(
      BluetoothScanCompleted event, Emitter<BluetoothConnectState> emit) {
    List<BluetoothDevice?> dataParsed = handleDevicesData(event.data);
    emit(BluetoothConnectDataReceived(dataParsed));
  }

  void _onScanError(
      BluetoothScanError event, Emitter<BluetoothConnectState> emit) {
    emit(BluetoothConnectError()); // Update state with error message
  }

  List<BluetoothDevice?> handleDevicesData(String jsonData) {
    var decoded = json.decode(jsonData);
    List<BluetoothDevice> devices = (decoded['results'] as List)
        .map((item) => BluetoothDevice.fromJson(item as Map<String, dynamic>))
        .toList();
    return devices;
  }

  void _onConnectDevice(
      ConnectDevice event, Emitter<BluetoothConnectState> emit) {
    socket.emit('connect_miband', {
      'device_address': event.device.address,
      'name': event.device.name,
      'auth_key': event.authKey,
      'is_driver': event.isDriver
    });
    emit(BluetoothDeviceConnecting());
  }

  void _onConnectDeviceSuccess(ConnectDeviceSuccess event, Emitter<BluetoothConnectState> emit) {
    emit(BluetoothConnectDeviceSuccess(event.device));
  }

  void _onConnectionError(
      ConnectionError event, Emitter<BluetoothConnectState> emit) {
      emit(BluetoothConnectError());
  }


  @override
  Future<void> close() {
    socket.off('connection_success');
    socket.off('scan_completed');
    socket.off('scan_error');
    return super.close();
  }
}

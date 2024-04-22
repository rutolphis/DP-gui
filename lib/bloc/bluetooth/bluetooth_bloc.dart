import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gui_flutter/bloc/socket/socket_bloc.dart';
import 'package:gui_flutter/bloc/socket/socket_state.dart';
import 'package:gui_flutter/models/bluetooth_device.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'bluetooth_event.dart';
import 'bluetooth_state.dart';

class BluetoothBloc extends Bloc<BluetoothEvent, BluetoothState> {
  final SocketBloc socketBloc;
  late final IO.Socket socket;

  BluetoothBloc({required this.socketBloc}) : super(BluetoothInitial()) {
    socket = socketBloc.socket;

    // Listen to the socket events directly
    socket.on('scan_completed', (data) {
      print('Scan completed with data: $data');
      add(BluetoothScanCompleted(json.encode(data)));  // Assuming you have a ScanCompleted event in your Bloc
    });

    socket.on('scan_error', (data) {
      print('Scan error with message: $data');
      add(BluetoothScanError(data['error']));  // Assuming you have a ScanError event in your Bloc
    });

    on<BluetoothScan>(_onScanBLE);
    on<BluetoothScanCompleted>(_onScanCompleted);  // Handle scan completed
    on<BluetoothScanError>(_onScanError);
    on<ConnectDevice>(_onConnectDevice);
  }

  void _onScanBLE(BluetoothScan event, Emitter<BluetoothState> emit) {
      socket.emit('scan_ble');
      emit(BluetoothScanning());
      print('BLE scan requested');
  }

  void _onScanCompleted(BluetoothScanCompleted event, Emitter<BluetoothState> emit) {
    List<BluetoothDevice?> dataParsed = handleDevicesData(event.data);
    emit(BluetoothDataReceived(dataParsed));  // Update state with scan data
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
    socket.emit('connect_miband', {'device_address': event.address, 'auth_key': event.authKey});
    emit(DeviceConnecting());
  }

  @override
  Future<void> close() {
    // Clean up resources when the BLoC is closed
    socket.off('scan_completed');
    socket.off('scan_error');
    return super.close();
  }
}


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gui_flutter/bloc/bluetooth/bluetooth_bloc.dart';
import 'package:gui_flutter/bloc/bluetooth/bluetooth_event.dart';
import 'package:gui_flutter/bloc/bluetooth_disconnect/bluetooth_disconnect_event.dart';
import 'package:gui_flutter/bloc/bluetooth_disconnect/bluetooth_disconnect_state.dart';
import 'package:gui_flutter/bloc/socket/socket_bloc.dart';
import 'package:gui_flutter/models/bluetooth_device.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class BluetoothDisconnectionBloc extends Bloc<BluetoothDisconnectionEvent, BluetoothDisconnectionState> {
  final SocketBloc socketBloc;
  late final IO.Socket socket;
  final BluetoothBloc bluetoothBloc;

  BluetoothDisconnectionBloc({required this.socketBloc, required this.bluetoothBloc}) : super(DisconnectionInitial()) {
    socket = socketBloc.socket;

    socket.on('disconnection_success', (data) {
      add(DisconnectedDevice(data['device_address']));
      bluetoothBloc.add(DisconnectDevice(data['device_address']));
    });

    socket.on('disconnection_error', (data) {
      add(ErrorDisconnectingDevice(data['error']));
    });

    on<DisconnectRequest>(_onDisconnectRequest);
    on<DisconnectedDevice>(_onDeviceDisconnected);
    on<ErrorDisconnectingDevice>(_onErrorDisconnectingDevice);
  }

  void _onDisconnectRequest(DisconnectRequest event, Emitter<BluetoothDisconnectionState> emit) {
    socket.emit('disconnect_miband', {'device_address': event.address});
    emit(DeviceDisconnecting());
  }

  void _onDeviceDisconnected(DisconnectedDevice event, Emitter<BluetoothDisconnectionState> emit) {
    emit(DeviceDisconnected(event.address));
  }

  void _onErrorDisconnectingDevice(ErrorDisconnectingDevice event, Emitter<BluetoothDisconnectionState> emit) {
    emit(DisconnectionError(event.error));
  }
}

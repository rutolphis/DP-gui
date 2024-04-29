import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gui_flutter/bloc/socket/socket_bloc.dart';
import 'package:gui_flutter/models/vehicle_data.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'vehicle_data_event.dart';
import 'vehicle_data_state.dart';

class VehicleDataBloc extends Bloc<VehicleDataEvent, VehicleDataState> {
  final SocketBloc socketBloc;
  late final IO.Socket socket;
  Timer? _timer;

  VehicleDataBloc({required this.socketBloc})
      : super(VehicleDataUpdate(VehicleData.initial())) {
    socket = socketBloc.socket;

    // Listen to socket events for vehicle data
    socket.on('vehicle_data', (data) {
      // Assuming `data` is already a Map that can be directly used
      var vehicleData = VehicleData.fromJson(data);
      // Add VehicleDataReceived event to the BLoC
      add(VehicleDataReceived(vehicleData));
    });

    // Set up event handlers for the BLoC
    on<VehicleDataReceived>((event, emit) {
      emit(VehicleDataUpdate(event.data));
      _resetTimer(); // Reset the timer on processing the received data
    });
    on<VehicleDataTimeout>((event, emit) {
      emit(VehicleDataError('No data received in the last 10 seconds.'));
    });
  }

  void _resetTimer() {
    _timer?.cancel(); // Cancel any existing timer
    _timer = Timer(Duration(seconds: 10), () {
      // After 10 seconds without receiving data, emit an error state
      add(VehicleDataTimeout());
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel(); // Ensure the timer is cancelled when the BLoC is closed
    socket.off('updated_vehicle_data');
    return super.close();
  }
}

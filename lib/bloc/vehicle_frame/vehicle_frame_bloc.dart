import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gui_flutter/bloc/socket/socket_bloc.dart';
import 'package:gui_flutter/bloc/vehicle_frame/vehicle_frame_event.dart';
import 'package:gui_flutter/bloc/vehicle_frame/vehicle_frame_state.dart';
import 'package:gui_flutter/models/vehicle_data.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;


class VehicleFrameBloc extends Bloc<VehicleFrameEvent, VehicleFrameState> {
  final SocketBloc socketBloc;
  late final IO.Socket socket;
  Timer? _timer;

  VehicleFrameBloc({required this.socketBloc})
      : super(VehicleFrameInitial()) {
    socket = socketBloc.socket;

    // Listen to socket events for vehicle data
    socket.on('vehicle_frame', (data) {
      // Assuming `data` is already a Map that can be directly used
      String? vehicleFrame = data['frame'];
      // Add VehicleDataReceived event to the BLoC
      add(VehicleFrameReceived(vehicleFrame));
    });

    // Set up event handlers for the BLoC
    on<VehicleFrameReceived>((event, emit) {
      emit(VehicleFrameUpdate(event.frame));
      _resetTimer(); // Reset the timer on processing the received data
    });
    on<VehicleFrameTimeout>((event, emit) {
      emit(VehicleFrameError('No data received in the last 10 seconds.'));
    });
  }

  void _resetTimer() {
    _timer?.cancel(); // Cancel any existing timer
    _timer = Timer(const Duration(seconds: 10), () {
      // After 10 seconds without receiving data, emit an error state
      add(VehicleFrameTimeout());
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel(); // Ensure the timer is cancelled when the BLoC is closed
    socket.off('updated_vehicle_data');
    return super.close();
  }
}
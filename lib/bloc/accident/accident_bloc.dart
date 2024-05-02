import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gui_flutter/bloc/accident/accident_event.dart';
import 'package:gui_flutter/bloc/accident/accident_state.dart';
import 'package:gui_flutter/bloc/socket/socket_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class AccidentBloc extends Bloc<AccidentEvent, AccidentState> {
  final SocketBloc socketBloc;
  late final IO.Socket socket;
  Timer? _timer;

  AccidentBloc({required this.socketBloc}) : super(AccidentInitialState()) {
    socket = socketBloc.socket;

    // Listen for the accident event from the backend
    socket.on('accident', (data) {
      add(AccidentDetected());
    });

    on<AccidentDetected>((event, emit) {
      emit(AccidentNotificationReceived());

      _timer = Timer(const Duration(seconds: 10), () {
        add(UserResponseToAccident(true)); // Automatically confirm after 10 seconds
      });
    });
    on<UserResponseToAccident>((event, emit) {
      _timer?.cancel();
      if (event.userConfirmed) {
        socket.emit('accident_response', {'status': event.userConfirmed});
        emit(AccidentUserConfirmed());

      } else {
        socket.emit('accident_response', {'status': event.userConfirmed});
        emit(AccidentUserDenied());

      }
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}

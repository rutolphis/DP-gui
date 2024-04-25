import 'package:gui_flutter/bloc/personal_info/personal_info_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gui_flutter/bloc/socket/socket_event.dart';
import 'package:gui_flutter/bloc/socket/socket_state.dart';

import '../emergency_contacts/emergency_contacts_bloc.dart';

class SocketBloc extends Bloc<SocketEvent, SocketState> {
  late IO.Socket socket;

  SocketBloc() : super(SocketInitial()) {
    socket = IO.io('http://127.0.0.1:6000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      'query': 'type=frontend',
    });

    // Handling the connection asynchronously
    socket.onConnect((_) async {
      add(ConnectedSocket());
      //add(RequestInitialization());  // This will be handled separately and should not cause issues
    });

    socket.on('initialized', (data) {
      if (data['vin'] != null) {
        add(ReceiveInitialization(data['vin']));
      }
    });

    socket.onDisconnect((_) => emit(SocketDisconnected()));

    on<ConnectSocket>(_onConnectSocket);
    on<DisconnectSocket>(_onDisconnectSocket);
    on<RequestInitialization>(_onRequestInitialization);
    on<ReceiveInitialization>(_onReceiveInitialization);
    on<ConnectedSocket>(_onConnectedSocket);

    add(ConnectSocket());
  }

  void _onConnectSocket(ConnectSocket event, Emitter<SocketState> emit) async  {
      socket.connect();
  }

  void _onConnectedSocket(ConnectedSocket event, Emitter<SocketState> emit) async  {
    emit(SocketConnected());
    add(RequestInitialization());
  }

  void _onDisconnectSocket(DisconnectSocket event, Emitter<SocketState> emit) {
    socket.disconnect();
    emit(SocketDisconnected());
  }

  void _onRequestInitialization(RequestInitialization event, Emitter<SocketState> emit) {
    if (state is SocketConnected) {
      socket.emit('init', {'request': 'initialization'});
    }
  }


  void _onReceiveInitialization(ReceiveInitialization event, Emitter<SocketState> emit) {

    emit(SocketInitialized(event.vin));
  }


  @override
  Future<void> close() {
    socket.dispose();
    return super.close();
  }
}

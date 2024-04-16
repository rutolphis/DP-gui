import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gui_flutter/bloc/socket/socket_event.dart';
import 'package:gui_flutter/bloc/socket/socket_state.dart';

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

    socket.on('scan_completed', (data) {
      print('Scan completed with data: $data');
      add(ScanCompleted(data));  // Assuming you have a ScanCompleted event in your Bloc
    });

    socket.on('scan_error', (data) {
      print('Scan error with message: $data');
      add(ScanError(data['error']));  // Assuming you have a ScanError event in your Bloc
    });

    socket.onDisconnect((_) => emit(SocketDisconnected()));

    on<ConnectSocket>(_onConnectSocket);
    on<DisconnectSocket>(_onDisconnectSocket);
    on<RequestInitialization>(_onRequestInitialization);
    on<ReceiveInitialization>(_onReceiveInitialization);
    on<ConnectedSocket>(_onConnectedSocket);
    on<ScanBLE>(_onScanBLE);
    on<ScanCompleted>(_onScanCompleted);  // Handle scan completed
    on<ScanError>(_onScanError);           // Handle scan error

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


  void _onScanBLE(ScanBLE event, Emitter<SocketState> emit) {
    if (state is SocketInitialized) {
      socket.emit('scan_ble');
      print('BLE scan requested');
    }
  }

  void _onScanCompleted(ScanCompleted event, Emitter<SocketState> emit) {
    emit(SocketScanCompleted(event.data));  // Update state with scan data
  }

  void _onScanError(ScanError event, Emitter<SocketState> emit) {
    emit(SocketScanError(event.message));  // Update state with error message
  }


  @override
  Future<void> close() {
    socket.dispose();
    return super.close();
  }
}

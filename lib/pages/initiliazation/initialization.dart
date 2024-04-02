import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gui_flutter/bloc/emergency_contacts/emergency_contacts_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../bloc/emergency_contacts/emergency_contacts_event.dart';

class InitializationPage extends StatefulWidget {
  final Widget child;
  const InitializationPage({Key? key, required this.child}) : super(key: key);

  @override
  _InitializationPageState createState() => _InitializationPageState();
}

class _InitializationPageState extends State<InitializationPage> {
  late IO.Socket socket;
  Timer? _initializationTimeout;
  bool isInitialized = false;
  bool shouldAttemptConnection = true;

  @override
  void initState() {
    super.initState();
    _attemptConnection();
    context.read<EmergencyContactsBloc>().add(LoadEmergencyContacts());
  }

  void _attemptConnection() {
    setState(() {
      shouldAttemptConnection = false; // Attempting to connect, hide button
    });

    socket = IO.io('http://127.0.0.1:6000', <String, dynamic>{
      'transports': ['websocket'],
    });

    socket.onConnect((_) {
      print('Connected');
      _setInitializationTimeout(); // Set a timeout for the initialization
    });

    socket.on('message', (data) {
      if (data['status'] == 'initialized') {
        _initializationTimeout?.cancel(); // Initialization successful, cancel timeout
        setState(() {
          isInitialized = true;
        });
      }
    });

    socket.onDisconnect((_) {
      print('Disconnected');
      _resetConnectionState(); // Reset state on disconnect
    });

    socket.onConnectError((data) {
      print('Connection error: $data');
      _resetConnectionState(); // Reset state on connection error
    });

    socket.connect();
  }

  void _setInitializationTimeout() {
    _initializationTimeout = Timer(Duration(seconds: 10), () {
      if (!isInitialized) {
        print('Initialization timeout');
        _resetConnectionState(); // Reset state on timeout
      }
    });
  }

  void _resetConnectionState() {
    if (!mounted) return;
    setState(() {
      shouldAttemptConnection = true;
      isInitialized = false; // Ensures "Try Again" button shows after disconnect
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: isInitialized
            ? widget.child
            : shouldAttemptConnection
            ? ElevatedButton(
          onPressed: _attemptConnection,
          child: Text('Try Again'),
        )
            : CircularProgressIndicator(),
      ),
    );
  }

  @override
  void dispose() {
    _initializationTimeout?.cancel();
    socket.dispose(); // Use dispose() for cleanup
    super.dispose();
  }
}


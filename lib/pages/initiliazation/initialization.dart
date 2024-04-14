import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gui_flutter/bloc/emergency_contacts/emergency_contacts_bloc.dart';
import 'package:gui_flutter/bloc/personal_info/personal_info_bloc.dart';
import 'package:gui_flutter/bloc/personal_info/personal_info_event.dart';
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
  bool isConnected = false; // Add a flag to track connection status

  @override
  void initState() {
    super.initState();
    _attemptConnection();
    context.read<EmergencyContactsBloc>().add(LoadEmergencyContacts());
    context.read<PersonalInfoBloc>().add(LoadPersonalInfo());
  }

  void _attemptConnection() {
    setState(() {
      isConnected = false;
      isInitialized = false;
    });

    socket = IO.io('http://127.0.0.1:6000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      'query': 'type=frontend',
    });

    socket.onConnect((_) {
      setState(() {
        isConnected = true;
      });
      _requestInitialization();
    });

    socket.onDisconnect((_) {
      setState(() {
        isConnected = false;
      });
    });

    socket.on('initialized', (data) {
      if (data['vin'] != null) {
        setState(() {
          isInitialized = true;
        });
      }
    });

    socket.connect();
  }

  void _requestInitialization() {
    if (isConnected) {
      socket.emit('init', {'request': 'initialization'});
    } else {
      _attemptConnection(); // Attempt to connect if not connected
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: isInitialized && isConnected
            ? widget.child
            : isConnected
            ? ElevatedButton(
          onPressed: _requestInitialization,
          child: const Text('Initialize'),
        )
            : ElevatedButton(
          onPressed: _attemptConnection,
          child: const Text('Connect'),
        ),
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


import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gui_flutter/bloc/emergency_contacts/emergency_contacts_bloc.dart';
import 'package:gui_flutter/bloc/personal_info/personal_info_bloc.dart';
import 'package:gui_flutter/bloc/personal_info/personal_info_event.dart';
import 'package:gui_flutter/bloc/socket/socket_bloc.dart';
import 'package:gui_flutter/bloc/socket/socket_event.dart';
import 'package:gui_flutter/bloc/socket/socket_state.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../bloc/emergency_contacts/emergency_contacts_event.dart';

class InitializationPage extends StatefulWidget {
  final Widget child;
  const InitializationPage({Key? key, required this.child}) : super(key: key);

  @override
  _InitializationPageState createState() => _InitializationPageState();
}

class _InitializationPageState extends State<InitializationPage> {

  @override
  void initState() {
    super.initState();
  }

 _downloadUserInformations(String vin) async {
    BlocProvider.of<PersonalInfoBloc>(context, listen: false).add(LoadPersonalInfo(vin));
    BlocProvider.of<EmergencyContactsBloc>(context, listen: false).add(LoadEmergencyContacts(vin));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocConsumer<SocketBloc, SocketState>(
          listener: (context, state) {
            if (state is SocketDisconnected) {
              // Handle disconnection event, show a dialog, or similar action
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Disconnected! Attempting to reconnect...'))
              );
              context.read<SocketBloc>().add(ConnectSocket());  // Auto-reconnect logic if desired
            }
            if (state is SocketInitialized) {
              _downloadUserInformations(state.vin);
            }
          },
          builder: (context, state) {
            if (state is SocketInitialized) {
              return widget.child;
            } else if (state is SocketConnected) {
              // If connected but not yet initialized, show initialization button
              return ElevatedButton(
                onPressed: () => context.read<SocketBloc>().add(RequestInitialization()),
                child: const Text('Initialize'),
              );
            } else {
              // If not connected, show connect button
              return ElevatedButton(
                onPressed: () => context.read<SocketBloc>().add(ConnectSocket()),
                child: const Text('Connect'),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}


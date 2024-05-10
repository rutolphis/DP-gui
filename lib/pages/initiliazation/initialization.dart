import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gui_flutter/bloc/accident/accident_bloc.dart';
import 'package:gui_flutter/bloc/accident/accident_event.dart';
import 'package:gui_flutter/bloc/accident/accident_state.dart';
import 'package:gui_flutter/bloc/emergency_contacts/emergency_contacts_bloc.dart';
import 'package:gui_flutter/bloc/personal_info/personal_info_bloc.dart';
import 'package:gui_flutter/bloc/personal_info/personal_info_event.dart';
import 'package:gui_flutter/bloc/socket/socket_bloc.dart';
import 'package:gui_flutter/bloc/socket/socket_event.dart';
import 'package:gui_flutter/bloc/socket/socket_state.dart';
import 'package:gui_flutter/constants/colors.dart';
import 'package:gui_flutter/constants/fonts.dart';
import 'package:gui_flutter/widgets/button.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../bloc/emergency_contacts/emergency_contacts_event.dart';

class InitializationPage extends StatefulWidget {
  final Widget child;

  const InitializationPage({Key? key, required this.child}) : super(key: key);

  @override
  _InitializationPageState createState() => _InitializationPageState();
}

class _InitializationPageState extends State<InitializationPage> {
  Timer? _closeTimer;

  @override
  void initState() {
    super.initState();
  }

  _downloadUserInformations(String vin) async {
    BlocProvider.of<PersonalInfoBloc>(context, listen: false)
        .add(LoadPersonalInfo(vin));
    BlocProvider.of<EmergencyContactsBloc>(context, listen: false)
        .add(LoadEmergencyContacts(vin));
  }

  _showAccidentDialog() {
    showDialog(
      barrierDismissible: false,
        context: context,
        builder: (context) {
          _closeTimer = Timer(const Duration(seconds: 10), () {
            if (Navigator.canPop(context)) {
              Navigator.of(context).pop();
            }
          });

          return AlertDialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              surfaceTintColor: Colors.transparent,
              backgroundColor: ColorConstants.white,
              contentPadding: const EdgeInsets.all(24),
              content: SizedBox(
                width: 600,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            "Accident was recorded!",
                            style: TextStylesConstants.h2,
                          ),
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(100),
                          onTap: () {
                            Navigator.of(context).pop(); // Closes the dialog
                          },
                          child: const CircleAvatar(
                            backgroundColor: ColorConstants.black,
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Flexible(
                      child: const Text(
                        "Hey, accident was recorded by our system, you have 10 seconds, to stop system from sending data to rescue services.",
                        style: TextStylesConstants.bodyLarge,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomButton(
                            color: Colors.red,
                            onTap: () {
                              BlocProvider.of<AccidentBloc>(context)
                                  .add(UserResponseToAccident(true));
                              Navigator.of(context).pop(); // Close the dialog;
                            },
                            text: "Send rescue services"),
                        CustomButton(
                            color: ColorConstants.primary,
                            onTap: () {
                              BlocProvider.of<AccidentBloc>(context)
                                  .add(UserResponseToAccident(false));
                              Navigator.of(context).pop(); // Close the dialog
                            },
                            text: "No Accident"),
                      ],
                    ),
                  ],
                ),
              ));
        }).then((_) {
      _closeTimer
          ?.cancel(); // Cancel the timer when the dialog is closed manually
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocListener<AccidentBloc, AccidentState>(
          listener: (context, state) {
            if (state is AccidentNotificationReceived) {
              _showAccidentDialog();
            }
          },
          child: BlocConsumer<SocketBloc, SocketState>(
            listener: (context, state) {
              if (state is SocketDisconnected) {
                // Handle disconnection event, show a dialog, or similar action
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Disconnected! Attempting to reconnect...')));
                context
                    .read<SocketBloc>()
                    .add(ConnectSocket()); // Auto-reconnect logic if desired
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
                  onPressed: () =>
                      context.read<SocketBloc>().add(RequestInitialization()),
                  child: const Text('Initialize'),
                );
              } else {
                // If not connected, show connect button
                return ElevatedButton(
                  onPressed: () =>
                      context.read<SocketBloc>().add(ConnectSocket()),
                  child: const Text('Connect'),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

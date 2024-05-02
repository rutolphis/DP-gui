import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gui_flutter/bloc/accident/accident_bloc.dart';
import 'package:gui_flutter/bloc/bluetooth/bluetooth_bloc.dart';
import 'package:gui_flutter/bloc/bluetooth_disconnect/bluetooth_disconnect_bloc.dart';
import 'package:gui_flutter/bloc/emergency_contacts/emergency_contacts_bloc.dart';
import 'package:gui_flutter/bloc/personal_info/personal_info_bloc.dart';
import 'package:gui_flutter/bloc/socket/socket_bloc.dart';
import 'package:gui_flutter/bloc/vehicle_data/vehicle_data_bloc.dart';
import 'package:gui_flutter/constants/colors.dart';
import 'package:gui_flutter/pages/initiliazation/initialization.dart';
import 'package:gui_flutter/widgets/navigation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<SocketBloc>(
            create: (context) => SocketBloc(),
          ),
          BlocProvider<EmergencyContactsBloc>(
            create: (context) => EmergencyContactsBloc(),
          ),
          BlocProvider<PersonalInfoBloc>(
            create: (context) => PersonalInfoBloc(),
          ),
          BlocProvider<BluetoothBloc>(
            create: (BuildContext context) => BluetoothBloc(
              socketBloc: BlocProvider.of<SocketBloc>(context, listen: false),
            ),
          ),
          BlocProvider<AccidentBloc>(
            create: (BuildContext context) => AccidentBloc(
              socketBloc: BlocProvider.of<SocketBloc>(context, listen: false),
            ),
          ),
          BlocProvider<BluetoothDisconnectionBloc>(
            create: (BuildContext context) => BluetoothDisconnectionBloc(
              socketBloc: BlocProvider.of<SocketBloc>(context, listen: false), bluetoothBloc: BlocProvider.of<BluetoothBloc>(context, listen: false),
            ),
          ),
          BlocProvider<VehicleDataBloc>(
            create: (BuildContext context) => VehicleDataBloc(
              socketBloc: BlocProvider.of<SocketBloc>(context, listen: false),
            ),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: ColorConstants.white),
            useMaterial3: true,
          ),
          home: InitializationPage(
            child: NavigationWidget(),
          ),
        ));
  }
}

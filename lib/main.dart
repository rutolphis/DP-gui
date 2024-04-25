import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:gui_flutter/bloc/bluetooth/bluetooth_bloc.dart';
import 'package:gui_flutter/bloc/emergency_contacts/emergency_contacts_bloc.dart';
import 'package:gui_flutter/bloc/personal_info/personal_info_bloc.dart';
import 'package:gui_flutter/bloc/socket/socket_bloc.dart';
import 'package:gui_flutter/bloc/socket/socket_event.dart';
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

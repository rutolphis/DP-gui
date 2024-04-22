import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gui_flutter/bloc/bluetooth/bluetooth_bloc.dart';
import 'package:gui_flutter/bloc/bluetooth/bluetooth_event.dart';
import 'package:gui_flutter/bloc/bluetooth/bluetooth_state.dart';
import 'package:gui_flutter/bloc/socket/socket_bloc.dart';
import 'package:gui_flutter/bloc/socket/socket_event.dart';
import 'package:gui_flutter/constants/colors.dart';
import 'package:gui_flutter/constants/fonts.dart';
import 'package:gui_flutter/pages/home/bluetooth/widgets/bluetooth_item.dart';
import 'package:gui_flutter/widgets/button.dart';
import 'package:gui_flutter/widgets/text_field.dart';

class DeviceConnectionResultPage extends StatefulWidget {
  const DeviceConnectionResultPage({Key? key}) : super(key: key);

  @override
  State<DeviceConnectionResultPage> createState() => _DeviceConnectionResultPageState();
}

class _DeviceConnectionResultPageState extends State<DeviceConnectionResultPage> {

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      const Text(
        "FINDED DEVICES",
        style: TextStylesConstants.h2,
      ),
      const SizedBox(
        height: 60,
      ),
      BlocBuilder<BluetoothBloc, BluetoothState>(builder: (context, state) {
        if (state is DeviceConnecting) {
          return Center(child: CircularProgressIndicator(),);
        } else {
          return Container();
        }
      })
    ]);
  }
}

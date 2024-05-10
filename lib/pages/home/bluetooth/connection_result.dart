import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gui_flutter/bloc/bluetooth/bluetooth_bloc.dart';
import 'package:gui_flutter/bloc/bluetooth/bluetooth_event.dart';
import 'package:gui_flutter/bloc/bluetooth/bluetooth_state.dart';
import 'package:gui_flutter/bloc/bluetooth_connect/bluetooth_connect_bloc.dart';
import 'package:gui_flutter/bloc/bluetooth_connect/bluetooth_connect_state.dart';
import 'package:gui_flutter/bloc/socket/socket_bloc.dart';
import 'package:gui_flutter/bloc/socket/socket_event.dart';
import 'package:gui_flutter/constants/colors.dart';
import 'package:gui_flutter/constants/fonts.dart';
import 'package:gui_flutter/pages/home/bluetooth/widgets/bluetooth_item.dart';
import 'package:gui_flutter/widgets/button.dart';
import 'package:gui_flutter/widgets/text_field.dart';
import 'package:jumping_dot/jumping_dot.dart';

class DeviceConnectionResultPage extends StatefulWidget {
  const DeviceConnectionResultPage({Key? key}) : super(key: key);

  @override
  State<DeviceConnectionResultPage> createState() =>
      _DeviceConnectionResultPageState();
}

class _DeviceConnectionResultPageState
    extends State<DeviceConnectionResultPage> {
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _closeDialog() {
    _timer = Timer(const Duration(seconds: 4), () {
      Navigator.pop(context);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      const Text(
        "CONNECTION STATUS",
        style: TextStylesConstants.h2,
      ),
      const SizedBox(
        height: 60,
      ),
      BlocBuilder<BluetoothConnectBloc, BluetoothConnectState>(builder: (context, state) {
        if (state is BluetoothDeviceConnecting) {
          return Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/car.svg',
                  width: 100,
                  height: 100,
                  color: ColorConstants.black,
                ),
                const SizedBox(width: 24,),
                JumpingDots(
                  color: ColorConstants.primary,
                  radius: 20,
                  numberOfDots: 5,
                  animationDuration: Duration(milliseconds: 400),
                ),
                const SizedBox(width: 24,),
                const Icon(Icons.watch, color: ColorConstants.black, size: 70,)
              ],
            ),
          );
        } else if (state is BluetoothConnectDeviceSuccess) {
          _closeDialog();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/icons/success.svg',
                color: ColorConstants.primary,
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                "Device ${state.device.name} has been connected!",
                style: TextStylesConstants.h2
                    .copyWith(color: ColorConstants.black),
                textAlign: TextAlign.center,
              ),
            ],
          );
        } else {
          _closeDialog();
          return Column(
            children: [
              SvgPicture.asset(
                'assets/icons/failure.svg',
              ),
              const SizedBox(
                height: 24,
              ),
              Text("Device wasn't able to connect!",
                  style: TextStylesConstants.h2
                      .copyWith(color: ColorConstants.black),
                  textAlign: TextAlign.center),
            ],
          );
        }
      })
    ]);
  }
}

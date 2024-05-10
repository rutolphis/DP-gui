import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gui_flutter/bloc/bluetooth/bluetooth_bloc.dart';
import 'package:gui_flutter/bloc/bluetooth/bluetooth_event.dart';
import 'package:gui_flutter/bloc/bluetooth/bluetooth_state.dart';
import 'package:gui_flutter/bloc/bluetooth_connect/bluetooth_connect_bloc.dart';
import 'package:gui_flutter/bloc/bluetooth_connect/bluetooth_connect_state.dart';
import 'package:gui_flutter/constants/fonts.dart';
import 'package:gui_flutter/pages/home/bluetooth/choose_device.dart';
import 'package:gui_flutter/pages/home/bluetooth/connection_result.dart';
import 'package:gui_flutter/pages/home/bluetooth/search_device.dart';

class BluetoothConnectDialog extends StatefulWidget {
  @override
  State<BluetoothConnectDialog> createState() => _BluetoothConnectDialogState();
}

class _BluetoothConnectDialogState extends State<BluetoothConnectDialog> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BluetoothConnectBloc, BluetoothConnectState>(
      listener: (context, state) {
        if(state is BluetoothDeviceScanning && _pageController.page == 1) {
          _pageController.animateToPage(
            0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
        else if (state is BluetoothConnectDataReceived) {
          _pageController.animateToPage(
            1,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        } else if (state is BluetoothDeviceConnecting) {
          _pageController.animateToPage(
            2,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      },
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.only(top: 72.0, left: 64, right: 64),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  size: 40,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const Text(
                'Connecting watch to the system',
                style: TextStylesConstants.bodyLarge,
              ),
              Container()
            ],
          ),
          const SizedBox(
            height: 60,
          ),
          Expanded(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              children: const <Widget>[
                DeviceSearchPage(),
                DeviceChoosePage(),
                DeviceConnectionResultPage()
              ],
            ),
          )
        ]),
      )),
    );
  }
}

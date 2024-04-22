import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gui_flutter/bloc/bluetooth/bluetooth_bloc.dart';
import 'package:gui_flutter/bloc/bluetooth/bluetooth_state.dart';
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
    return BlocConsumer<BluetoothBloc, BluetoothState>(
      listener: (context, state) {
        if (state is BluetoothDataReceived && state.data.isNotEmpty) {
          _pageController.animateToPage(
            1,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        } else if (state is DeviceConnecting) {
          _pageController.animateToPage(
            2,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
            body: Padding(
              padding: const EdgeInsets.only(top: 72.0, left: 64, right: 64),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        size: 40,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Text(
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
                    controller: _pageController,
                    children: <Widget>[
                      DeviceSearchPage(),
                      DeviceChoosePage(),
                      DeviceConnectionResultPage()
                      // Add more screens as needed
                    ],
                  ),
                )
              ]),
            ));
      },
    );
  }
}

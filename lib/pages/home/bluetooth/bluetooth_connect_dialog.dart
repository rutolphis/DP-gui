import 'package:flutter/material.dart';
import 'package:gui_flutter/constants/fonts.dart';
import 'package:gui_flutter/pages/home/bluetooth/search_device.dart';

class BluetoothConnectDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            children: <Widget>[
              DeviceSearchPage(),
              Center(child: Text('Screen 2')),
              // Add more screens as needed
            ],
          ),
        )
      ]),
    ));
  }
}

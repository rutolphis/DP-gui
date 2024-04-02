import 'package:flutter/material.dart';
import 'package:gui_flutter/constants/fonts.dart';
class DeviceSearchPage extends StatefulWidget {
  const DeviceSearchPage({Key? key}) : super(key: key);

  @override
  State<DeviceSearchPage> createState() => _DeviceSearchPageState();
}

class _DeviceSearchPageState extends State<DeviceSearchPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
          "Searching for devices",
          style: TextStylesConstants.h2,
        ));
  }
}

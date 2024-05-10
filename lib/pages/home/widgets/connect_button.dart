import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gui_flutter/bloc/bluetooth/bluetooth_bloc.dart';
import 'package:gui_flutter/bloc/bluetooth/bluetooth_state.dart';
import 'package:gui_flutter/bloc/bluetooth_disconnect/bluetooth_disconnect_bloc.dart';
import 'package:gui_flutter/bloc/bluetooth_disconnect/bluetooth_disconnect_event.dart';
import 'package:gui_flutter/bloc/bluetooth_disconnect/bluetooth_disconnect_state.dart';
import 'package:gui_flutter/constants/colors.dart';
import 'package:gui_flutter/constants/fonts.dart';
import 'package:gui_flutter/models/bluetooth_device.dart';
import 'package:gui_flutter/widgets/button.dart';
import 'dart:math' as math;

import 'package:tuple/tuple.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gui_flutter/bloc/emergency_contacts/emergency_contacts_bloc.dart';
import 'package:gui_flutter/bloc/emergency_contacts/emergency_contacts_event.dart';
import 'package:gui_flutter/bloc/emergency_contacts/emergency_contacts_state.dart';
import 'package:gui_flutter/constants/colors.dart';
import 'package:gui_flutter/constants/fonts.dart';
import 'package:gui_flutter/models/contact.dart';
import 'package:gui_flutter/widgets/progress_indicator.dart';
import 'package:gui_flutter/widgets/text_field.dart';

class _DisconnectDeviceDialog extends StatelessWidget {
  final String? name;
  final String? address;

  const _DisconnectDeviceDialog(
      {super.key, required this.name, required this.address});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      surfaceTintColor: Colors.transparent,
      backgroundColor: ColorConstants.white,
      contentPadding: const EdgeInsets.all(24),
      content:
          BlocConsumer<BluetoothDisconnectionBloc, BluetoothDisconnectionState>(
        builder: (context, state) {
          if (state is DeviceDisconnected || state is DisconnectionInitial) {
            return Container(
              width: 400,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          "Disconnect smartwatches",
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
                  Text(
                    "Are you really sure that you want to disconnect ${name}",
                    style: TextStylesConstants.bodyLarge,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  CustomButton(
                    color: Colors.red,
                      onTap: () {
                        var state = context.read<EmergencyContactsBloc>().state;
                        if (state is EmergencyContactsLoaded) {
                          BlocProvider.of<BluetoothDisconnectionBloc>(context)
                              .add(DisconnectRequest(address!));
                        }
                      },
                      text: "Disconnect smartwatch"),
                ],
              ),
            );
          } else {
            return const SizedCircularProgressIndicator();
          }
        },
        listenWhen: (previous, current) {
          if (previous is DeviceDisconnecting &&
              current is DeviceDisconnected) {
            return true;
          } else {
            return false;
          }
        },
        listener: (BuildContext context, BluetoothDisconnectionState state) {
          if (state is DeviceDisconnected) {
            Navigator.of(context).pop();
          }
        },
      ),
    );
  }
}

class ConnectButtonWidget extends StatefulWidget {
  final VoidCallback onTap;

  ConnectButtonWidget({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  State<ConnectButtonWidget> createState() => _ConnectButtonWidgetState();
}

class _ConnectButtonWidgetState extends State<ConnectButtonWidget> {
  late List<BluetoothDevice> devices;

  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BluetoothBloc, BluetoothState>(
        builder: (context, state) {
      if (state is ConnectedDevices) {
        devices = state.devices;
        return DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            isExpanded: false,
            customButton: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.bluetooth,
                  color: ColorConstants.primary,
                  size: 35,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  "Smartwatches",
                  style: TextStylesConstants.bodyLarge
                      .copyWith(color: ColorConstants.primary),
                ),
                const SizedBox(
                  width: 8,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Transform.rotate(
                    angle: -math.pi / 2,
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: ColorConstants.primary,
                      size: 30,
                    ),
                  ),
                )
              ],
            ),
            onChanged: (String? value) {
              setState(() {
                selectedValue = value;
              });
              if (selectedValue == "add") {
                widget.onTap();
              } else {
                BluetoothDevice? foundDevice = devices
                    .firstWhere((device) => device.address == selectedValue);

                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return _DisconnectDeviceDialog(
                        name: foundDevice.name,
                        address: foundDevice.address,
                      );
                    });
              }
            },
            items: devices.map((BluetoothDevice item) {
              return DropdownMenuItem<String>(
                  value: item.address,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          item.name,
                          style: TextStylesConstants.bodyLarge.copyWith(
                              color: ColorConstants.black,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const SizedBox(
                        height: 30,
                        width: 30,
                        child: CircleAvatar(
                          backgroundColor: ColorConstants.black,
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                      ),
                    ],
                  ));
            }).toList()
              ..add(DropdownMenuItem<String>(
                  value: "add",
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          "Connect watch",
                          style: TextStylesConstants.bodyLarge
                              .copyWith(color: ColorConstants.primary),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      SvgPicture.asset(
                        'assets/icons/add-circle.svg',
                        width: 30,
                        height: 30,
                      ),
                    ],
                  ))),
            dropdownStyleData: DropdownStyleData(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
            ),
            menuItemStyleData: const MenuItemStyleData(
              height: 50,
            ),
          ),
        );
      } else {
        return CustomButton(
          icon: const Icon(
            IconData(0xe0e4, fontFamily: 'MaterialIcons'),
            size: 30,
            color: Colors.white,
            weight: 300,
          ),
          onTap: widget.onTap,
          text: 'Connect watch',
        );
      }
    });
  }
}

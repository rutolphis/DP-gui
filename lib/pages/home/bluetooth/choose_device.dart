import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gui_flutter/bloc/bluetooth/bluetooth_bloc.dart';
import 'package:gui_flutter/bloc/bluetooth/bluetooth_event.dart';
import 'package:gui_flutter/bloc/bluetooth/bluetooth_state.dart';
import 'package:gui_flutter/bloc/socket/socket_bloc.dart';
import 'package:gui_flutter/bloc/socket/socket_event.dart';
import 'package:gui_flutter/constants/colors.dart';
import 'package:gui_flutter/constants/fonts.dart';
import 'package:gui_flutter/models/bluetooth_device.dart';
import 'package:gui_flutter/pages/home/bluetooth/widgets/bluetooth_item.dart';
import 'package:gui_flutter/widgets/button.dart';
import 'package:gui_flutter/widgets/text_field.dart';

class DeviceChoosePage extends StatefulWidget {
  const DeviceChoosePage({Key? key}) : super(key: key);

  @override
  State<DeviceChoosePage> createState() => _DeviceChoosePageState();
}

class _DeviceChoosePageState extends State<DeviceChoosePage> {
  String? selectedAddress;
  BluetoothDevice? selectedDevice;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _authKeyController = TextEditingController();

  bool isDriver = false;

  void _showPairDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding:
              const EdgeInsets.only(top: 24, right: 24, left: 24, bottom: 24),
          surfaceTintColor: Colors.transparent,
          backgroundColor: ColorConstants.white,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(8.0), // Set the border radius to 8
          ),
          content: SizedBox(
            width: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Add Auth key",
                      style: TextStylesConstants.h2,
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
                const SizedBox(
                  height: 24,
                ),
                Form(
                  key: _formKey,
                  child: CustomTextFieldWidget(
                    controller: _authKeyController,
                    hintText: "Auth Key",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Auth key can't be blank";
                      }

                      if (value.length < 32) {
                        return 'Auth key should be 32 characters long';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                  return Row(
                    children: [
                      Transform.scale(
                          scale: 1.3,
                          child: Checkbox(
                              activeColor: ColorConstants.primary,
                              value: isDriver,
                              onChanged: (bool? value) {
                                setState(() {
                                  isDriver = value!;
                                });
                              })),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text(
                        "Driver's smartwatches",
                        style: TextStylesConstants.bodyBase,
                      )
                    ],
                  );
                }),
                const SizedBox(
                  height: 24,
                ),
                CustomButton(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      String authKey = _authKeyController.text;
                      Navigator.of(context).pop();
                      BlocProvider.of<BluetoothBloc>(context).add(
                          ConnectDevice(selectedDevice!, authKey, isDriver));
                    }
                  },
                  text: "Pair",
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BluetoothBloc, BluetoothState>(builder: (context, state) {
      if (state is BluetoothDataReceived && state.data.isNotEmpty) {
        return Flexible(
          child: Column(
            children: [
              const Text(
                "FINDED DEVICES",
                style: TextStylesConstants.h2,
              ),
              const SizedBox(
                height: 60,
              ),
              Flexible(
                child: ListView.builder(
                  itemCount: state.data.length,
                  itemBuilder: (context, index) {
                    final device = state.data[index];
                    bool isSelected =
                        device?.address == selectedDevice?.address;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 24.0),
                      child: BluetoothItemWidget(
                        name: device!.name,
                        address: device!.address,
                        isSelected: isSelected,
                        onTap: () {
                          setState(() {
                            if (selectedDevice?.address == device.address) {
                              selectedDevice =
                                  null; // Deselect if the same address is tapped again
                            } else {
                              selectedDevice = device;
                            }
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: CustomButton(
                  onTap: () =>
                      {if (selectedDevice != null) _showPairDialog()},
                  text: "Pair device",
                  disabled: selectedDevice == null,
                ),
              ),
              const SizedBox(
                height: 80,
              )
            ],
          ),
        );
      } else {
        return Flexible(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "NO FINDED DEVICES",
              style: TextStylesConstants.h2,
            ),
            SvgPicture.asset(
              'assets/icons/nothing_found.svg',
              width: 300,
              height: 300,
              color: ColorConstants.black,
            ),
            CustomButton(
              onTap: () =>
                  {context.read<BluetoothBloc>().add(BluetoothScan())},
              text: "Try Again",
            ),
            const SizedBox(height: 80,)
          ],
        ));
      }
    });
  }
}

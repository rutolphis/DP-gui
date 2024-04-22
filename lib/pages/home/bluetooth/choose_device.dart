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

class DeviceChoosePage extends StatefulWidget {
  const DeviceChoosePage({Key? key}) : super(key: key);

  @override
  State<DeviceChoosePage> createState() => _DeviceChoosePageState();
}

class _DeviceChoosePageState extends State<DeviceChoosePage> {
  String? selectedAddress;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _authKeyController = TextEditingController();

  void _showPairDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.only(top: 24, right: 24, left: 24, bottom: 24),
          surfaceTintColor: Colors.transparent,
          backgroundColor: ColorConstants.white,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(8.0), // Set the border radius to 8
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Add Auth key", style: TextStylesConstants.h2,),
                  const SizedBox(width: 40,),
                  InkWell(
                    borderRadius: BorderRadius.circular(100),
                    onTap: () {
                      Navigator.of(context).pop(); // Closes the dialog
                    },
                    child: const CircleAvatar(
                      backgroundColor: ColorConstants.black,
                      child: Icon(Icons.close, color: Colors.white,size: 30,),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24,),
              Form(
                key: _formKey,
                child: CustomTextFieldWidget(
                  controller: _authKeyController,
                  hintText:  "Auth Key",
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
              const SizedBox(height: 24,),
              CustomButton(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    String authKey = _authKeyController.text;
                    Navigator.of(context).pop();
                    BlocProvider.of<BluetoothBloc>(context).add(ConnectDevice(selectedAddress!, authKey));
                  }
                },
                text: "Pair",
              )
            ],
          ),
        );
      },
    );
  }

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
        if (state is BluetoothDataReceived) {
          return Flexible(
            child: Column(
              children: [
                Flexible(
                  child: ListView.builder(
                    itemCount: state.data.length,
                    itemBuilder: (context, index) {
                      final device = state.data[index];
                      bool isSelected = device?.address == selectedAddress;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 24.0),
                        child: BluetoothItemWidget(
                          name: device!.name,
                          address: device!.address,
                          isSelected: isSelected,
                          onTap: () {
                            setState(() {
                              if (selectedAddress == device.address) {
                                selectedAddress =
                                    null; // Deselect if the same address is tapped again
                              } else {
                                selectedAddress =
                                    device.address; // Update selected address
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
                        {if (selectedAddress != null) _showPairDialog()},
                    text: "Pair device",
                    disabled: selectedAddress == null,
                  ),
                ),
                const SizedBox(
                  height: 80,
                )
              ],
            ),
          );
        } else {
          return Container();
        }
      })
    ]);
  }
}

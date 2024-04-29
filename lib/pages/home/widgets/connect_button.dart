import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gui_flutter/bloc/bluetooth/bluetooth_bloc.dart';
import 'package:gui_flutter/bloc/bluetooth/bluetooth_state.dart';
import 'package:gui_flutter/constants/colors.dart';
import 'package:gui_flutter/constants/fonts.dart';
import 'package:gui_flutter/widgets/button.dart';
import 'dart:math' as math;

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
  late List<String> devices;

  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BluetoothBloc, BluetoothState>(
        builder: (context, state) {
      if (state is NoConnectedDevices) {
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
      } else if (state is ConnectedDevices) {
        devices = state.devices.map((device) => device.name).toList();
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
            value: selectedValue,
            onChanged: (String? value) {
              setState(() {
                selectedValue = value;
              });
              if(selectedValue == "add") {
                widget.onTap();
              }
            },
            items: devices.map((String item) {
              return DropdownMenuItem<String>(
                  value: item,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          item,
                          style: TextStylesConstants.bodyLarge
                              .copyWith(color: ColorConstants.black, overflow: TextOverflow.ellipsis),
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
        return Container();
      }
    });
  }
}

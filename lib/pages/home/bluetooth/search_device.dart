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

class DeviceSearchPage extends StatefulWidget {
  const DeviceSearchPage({Key? key}) : super(key: key);

  @override
  State<DeviceSearchPage> createState() => _DeviceSearchPageState();
}

class _DeviceSearchPageState extends State<DeviceSearchPage>
    with TickerProviderStateMixin {
  @override
  late AnimationController _animationController1;
  late AnimationController _animationController2;
  late Animation<double> _animationSize1;
  late Animation<double> _animationSize2;
  late Animation<double> _animationOpacity1;
  late Animation<double> _animationOpacity2;

  @override
  void initState() {
    super.initState();
    _circleAnimation();
    context.read<BluetoothBloc>().add(BluetoothScan());
  }

  void _circleAnimation() {
    _animationController1 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animationController2 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // Size animations
    _animationSize1 =
        Tween<double>(begin: 120.0, end: 360.0).animate(CurvedAnimation(
          parent: _animationController1,
          curve: Curves.easeInOut,
          reverseCurve: Curves.easeInOut,
        ));

    _animationSize2 =
        Tween<double>(begin: 120.0, end: 360.0).animate(CurvedAnimation(
          parent: _animationController2,
          curve: Curves.easeInOut,
          reverseCurve: Curves.easeInOut,
        ));

    // Opacity animations
    _animationOpacity1 =
        Tween<double>(begin: 0.0, end: 0.6).animate(CurvedAnimation(
          parent: _animationController1,
          curve: Curves.easeInOut,
          reverseCurve: Curves.easeInOut,
        ));

    _animationOpacity2 =
        Tween<double>(begin: 0.0, end: 0.6).animate(CurvedAnimation(
          parent: _animationController2,
          curve: Curves.easeInOut,
          reverseCurve: Curves.easeInOut,
        ));

    _animationController1.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController1.repeat();
      } else if (status == AnimationStatus.dismissed) {
        _animationController1.forward();
      }
    });

    _animationController2.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController2.repeat();
      } else if (status == AnimationStatus.dismissed) {
        _animationController2.forward();
      }
    });

    _animationController1.forward();
    Future.delayed(const Duration(milliseconds: 700), () {
      _animationController2.forward();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController1.dispose();
    _animationController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Searching for devices",
          style: TextStylesConstants.h2,
        ),
        BlocBuilder<BluetoothBloc, BluetoothState>(builder: (context, state) {
          if (state is BluetoothScanning) {
            return Column(
              children: [
                const SizedBox(height: 50),
                SizedBox(
                  height: 360,
                  width: 360,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      AnimatedBuilder(
                        animation: Listenable.merge(
                            [_animationController1, _animationOpacity1]),
                        builder: (BuildContext context, Widget? child) {
                          return Opacity(
                            opacity: _animationOpacity1.value,
                            child: Container(
                              width: _animationSize1.value,
                              height: _animationSize1.value,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColorConstants.primary,
                              ),
                            ),
                          );
                        },
                      ),
                      AnimatedBuilder(
                        animation: Listenable.merge(
                            [_animationController2, _animationOpacity2]),
                        builder: (BuildContext context, Widget? child) {
                          return Opacity(
                            opacity: _animationOpacity2.value,
                            child: Container(
                              width: _animationSize2.value,
                              height: _animationSize2.value,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColorConstants.primary,
                              ),
                            ),
                          );
                        },
                      ),
                      Container(
                        width: 120,
                        height: 120,
                        child: Icon(
                          Icons.bluetooth,
                          color: ColorConstants.white,
                          size: 100,
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorConstants.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else if (state is BluetoothError) {
            return Text("error");
          } else if( state is BluetoothDataReceived && state.data.isEmpty){
            return Text("No devices found");;
          }
          else {
          return Container();
          }
        }),
      ],
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gui_flutter/bloc/bluetooth/bluetooth_bloc.dart';
import 'package:gui_flutter/bloc/bluetooth/bluetooth_event.dart';
import 'package:gui_flutter/bloc/bluetooth/bluetooth_state.dart';
import 'package:gui_flutter/bloc/bluetooth_connect/bluetooth_connect_bloc.dart';
import 'package:gui_flutter/bloc/bluetooth_connect/bluetooth_connect_state.dart';
import 'package:gui_flutter/constants/colors.dart';
import 'package:gui_flutter/constants/fonts.dart';

import '../../../bloc/bluetooth_connect/bluetooth_connect_event.dart';

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
    context.read<BluetoothConnectBloc>().add(BluetoothScan());
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
        const Text(
          "SEARCHING FOR DEVICES",
          style: TextStylesConstants.h2,
        ),
        const SizedBox(height: 50),
        BlocBuilder<BluetoothConnectBloc, BluetoothConnectState>(builder: (context, state) {
          if (state is BluetoothDeviceScanning) {
            return Column(
              children: [
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
                              decoration: const BoxDecoration(
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
                              decoration: const BoxDecoration(
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
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorConstants.black,
                        ),
                        child: const Icon(
                          Icons.bluetooth,
                          color: ColorConstants.white,
                          size: 100,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else if (state is BluetoothConnectError) {
            return Column(
              children: [
                SvgPicture.asset(
                  'assets/icons/failure.svg',
                ),
                const SizedBox(
                  height: 24,
                ),
                Text("Some problem happened, try restart device!",
                    style: TextStylesConstants.h2
                        .copyWith(color: ColorConstants.black),
                    textAlign: TextAlign.center),
              ],
            );
          }
          else {
          return Container();
          }
        }),
      ],
    );
  }
}

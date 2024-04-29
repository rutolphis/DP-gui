import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gui_flutter/bloc/vehicle_data/vehicle_data_bloc.dart';
import 'package:gui_flutter/bloc/vehicle_data/vehicle_data_state.dart';
import 'package:gui_flutter/constants/colors.dart';
import 'package:gui_flutter/constants/fonts.dart';
import 'package:gui_flutter/pages/home/widgets/home_container.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class SpeedWidget extends StatefulWidget {
  const SpeedWidget({Key? key}) : super(key: key);

  @override
  State<SpeedWidget> createState() => _SpeedWidgetState();
}

class _SpeedWidgetState extends State<SpeedWidget> {
  int speed = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VehicleDataBloc, VehicleDataState>(
        builder: (context, state) {
      if (state is VehicleDataUpdate) {
        speed = state.data.speed; // Assuming speed comes from state
      } else {
        speed = 0;
      }
      return HomeContainerWidget(
          height: 300,
          title: "Speed",
          child: Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(
                  height: 24,
                ),
                Expanded(
                  child: SfRadialGauge(enableLoadingAnimation: true,animationDuration:500,axes: <RadialAxis>[
                    RadialAxis(
                      annotations: <GaugeAnnotation>[
                        GaugeAnnotation(
                          positionFactor: 0,
                          angle: 270,
                          widget: Text(
                            speed.toString(),
                            style: TextStylesConstants.h2
                                .copyWith(color: ColorConstants.grey),
                          ),
                          verticalAlignment: GaugeAlignment.near,
                          horizontalAlignment: GaugeAlignment.center,
                        )
                      ],
                      minimum: 0,
                      maximum: 240,
                      showLabels: false,
                      showTicks: false,
                      pointers: <GaugePointer>[
                        RangePointer(
                          enableAnimation: true,
                          value: speed.toDouble(),
                          color: ColorConstants.primary,
                          width: 30,
                          gradient: const SweepGradient(colors: <Color>[
                            ColorConstants.primary,
                            Color(0xFFFCCD65)
                          ], stops: <double>[
                            0.25,
                            0.75
                          ]),
                        )
                      ],
                      axisLineStyle: const AxisLineStyle(
                          thickness: 30, color: ColorConstants.white),
                    )
                  ]),
                ),
              ],
            ),
          ));
    });
  }
}

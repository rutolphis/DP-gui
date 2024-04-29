import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gui_flutter/bloc/vehicle_data/vehicle_data_bloc.dart';
import 'package:gui_flutter/bloc/vehicle_data/vehicle_data_state.dart';
import 'package:gui_flutter/pages/home/widgets/stats_item.dart';

import 'home_container.dart';

class CarStatsWidget extends StatefulWidget {
  const CarStatsWidget({Key? key}) : super(key: key);

  @override
  State<CarStatsWidget> createState() => _CarStatsWidgetState();
}

class _CarStatsWidgetState extends State<CarStatsWidget> {
  int rpm = 0;
  int steering_wheel = 0;
  int acceleration_pedal = 0;
  bool brake_pedal = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VehicleDataBloc, VehicleDataState>(
        builder: (context, state) {
      if (state is VehicleDataUpdate) {
        rpm = state.data.rpm;
        steering_wheel = state.data.steeringWheelAngle;
        acceleration_pedal = state.data.accelerationPedal;
        brake_pedal = state.data.brakePedal;
      } else {
        rpm = 0;
        steering_wheel = 0;
        acceleration_pedal = 0;
        brake_pedal = false;
      }
      return HomeContainerWidget(
        title: "Car stats",
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StatsItemWidget(
                        title: 'RPM',
                        value: rpm.toString(),
                      ),
                      SizedBox(height: 10,),
                      StatsItemWidget(
                        title: 'Steering wheel',
                        value: steering_wheel.toString(),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StatsItemWidget(
                        title: 'Acceleration pedal',
                        value: acceleration_pedal.toString(),
                      ),
                      SizedBox(height: 10,),
                      StatsItemWidget(
                        title: 'Brake pedal',
                        value: brake_pedal ? "True" : "False",
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}

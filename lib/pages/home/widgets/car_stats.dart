import 'package:flutter/material.dart';
import 'package:gui_flutter/pages/home/widgets/stats_item.dart';

import 'home_container.dart';

class CarStatsWidget extends StatefulWidget {
  const CarStatsWidget({Key? key}) : super(key: key);

  @override
  State<CarStatsWidget> createState() => _CarStatsWidgetState();
}

class _CarStatsWidgetState extends State<CarStatsWidget> {
  @override
  Widget build(BuildContext context) {
    return const HomeContainerWidget(
      title: "Car stats",
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    StatsItemWidget(
                      title: 'Acceleration',
                      value: '1500',
                    ),
                    SizedBox(height: 10,),
                    StatsItemWidget(
                      title: 'Acceleration',
                      value: '1500',
                    )
                  ],
                ),
                Column(
                  children: [
                    StatsItemWidget(
                      title: 'Acceleration',
                      value: '1500',
                    ),
                    SizedBox(height: 10,),
                    StatsItemWidget(
                      title: 'Acceleration',
                      value: '1500',
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

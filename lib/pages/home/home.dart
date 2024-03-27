import 'package:flutter/material.dart';
import 'package:gui_flutter/pages/home/widgets/car_stats.dart';
import 'package:gui_flutter/pages/home/widgets/stats_item.dart';
import 'package:gui_flutter/widgets/image_container.dart';
import 'package:gui_flutter/pages/home/widgets/home_container.dart';
import 'package:gui_flutter/widgets/page.dart';

import 'package:gui_flutter/pages/home/widgets/connect_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageWidget(
        button: ConnectButtonWidget(
          onTap: () {},
        ),
        title: "Dashboard",
        body: const Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  HomeContainerWidget(
                    title: "Speed",
                    child: Text("flutter"),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 40,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ImageContainerWidget(
                    height: 150,
                    backgroundImage: "assets/images/test_photo.jpg",
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  CarStatsWidget()
                ],
              ),
            )
          ],
        ));
  }
}

import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gui_flutter/constants/colors.dart';
import 'package:gui_flutter/pages/home/widgets/home_container.dart';
import 'package:latlong2/latlong.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({Key? key}) : super(key: key);

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  LatLng position = LatLng(48.151698, 17.073334);
  @override
  void initState() {

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return HomeContainerWidget(
      padding: EdgeInsets.zero,
      height: 200,
        child: Expanded(
          child: ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: FlutterMap(
            options: MapOptions(
              minZoom: 16,
              maxZoom: 16,
              initialCenter: position,
              // Initial latitude and longitude
              initialZoom: 16.0, // Initial zoom level
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: position,
                    width: 40,
                    height: 40,
                    child: SvgPicture.asset(
                      'assets/icons/car.svg',
                      color: ColorConstants.primary,
                    ),
                  ),
                ],
              ),
              // Add more layers here, such as MarkerLayerOptions if you need markers
            ]),
    ),
        ));
  }
}

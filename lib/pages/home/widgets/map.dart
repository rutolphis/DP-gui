import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gui_flutter/bloc/vehicle_data/vehicle_data_bloc.dart';
import 'package:gui_flutter/bloc/vehicle_data/vehicle_data_state.dart';
import 'package:gui_flutter/constants/colors.dart';
import 'package:gui_flutter/pages/home/widgets/home_container.dart';
import 'package:gui_flutter/widgets/progress_indicator.dart';
import 'package:latlong2/latlong.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({Key? key}) : super(key: key);

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  late final MapController _mapController;
  LatLng markerPosition = const LatLng(51.5, -0.09);

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  void updatePosition(LatLng newPosition) {
    setState(() {
      if (_mapController != null) {
        markerPosition = newPosition;
        _mapController.move(newPosition, 16);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return HomeContainerWidget(
        padding: EdgeInsets.zero,
        height: 200,
        child: Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: BlocConsumer<VehicleDataBloc, VehicleDataState>(
              builder: (context, state) {
                if (state is VehicleDataUpdate) {
                  return FlutterMap(
                      mapController: _mapController,
                      options: MapOptions(
                        initialCenter: markerPosition,
                        minZoom: 16,
                        maxZoom: 16,
                        // Initial latitude and longitude
                        initialZoom: 16.0, // Initial zoom level
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.example.app',
                        ),
                        MarkerLayer(
                          markers: [
                            Marker(
                              point: markerPosition,
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
                      ]);
                } else {
                  return const SizedCircularProgressIndicator();
                }
              },
              listenWhen: (previous, current) {
                if(previous is VehicleDataUpdate &&  current is VehicleDataUpdate) {
                  return true;
                }
                return false;
              },
              listener: (BuildContext context, VehicleDataState state) {
                if (state is VehicleDataUpdate) {
                  LatLng position =
                      LatLng(state.data.latitude, state.data.longitude);
                  updatePosition(position);
                }
              },
            ),
          ),
        ));
  }
}

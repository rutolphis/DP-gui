import 'package:gui_flutter/models/vehicle_data.dart';

abstract class VehicleFrameEvent {}

class VehicleFrameReceived extends VehicleFrameEvent {
  final String? frame;

  VehicleFrameReceived(this.frame);
}

class VehicleFrameTimeout extends VehicleFrameEvent {}
import 'package:gui_flutter/models/vehicle_data.dart';

abstract class VehicleFrameState {}

class VehicleFrameInitial extends VehicleFrameState {}

class VehicleFrameUpdate extends VehicleFrameState {
  final String? frame;

  VehicleFrameUpdate(this.frame);
}

class VehicleFrameError extends VehicleFrameState {
  final String message;

  VehicleFrameError(this.message);
}
import 'package:gui_flutter/models/vehicle_data.dart';

abstract class VehicleDataState {}

class VehicleDataInitial extends VehicleDataState {}

class VehicleDataUpdate extends VehicleDataState {
  final VehicleData data;

  VehicleDataUpdate(this.data);
}

class VehicleDataError extends VehicleDataState {
  final String message;

  VehicleDataError(this.message);
}


import 'package:gui_flutter/models/vehicle_data.dart';

abstract class VehicleDataEvent {}

class VehicleDataReceived extends VehicleDataEvent {
  final VehicleData data;

  VehicleDataReceived(this.data);
}

class VehicleDataTimeout extends VehicleDataEvent {}
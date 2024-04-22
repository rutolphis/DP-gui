import 'package:gui_flutter/models/bluetooth_device.dart';

class Smartwatch extends BluetoothDevice {
  final int heartRate;

  Smartwatch({
    required String name,
    required String address,
    required this.heartRate,
  }) : super(name: name, address: address);

  // Overriding toJson method to include heartRate
  @override
  Map<String, dynamic> toJson() {
    return super.toJson()..addAll({'heartRate': heartRate});
  }

  // Factory constructor to create a Smartwatch from JSON
  factory Smartwatch.fromJson(Map<String, dynamic> json) {
    return Smartwatch(
      name: json['name'],
      address: json['address'],
      heartRate: json['heartRate'] ?? 0,  // Defaulting to 0 if heartRate is not present
    );
  }
}


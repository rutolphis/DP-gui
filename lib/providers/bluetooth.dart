import 'package:gui_flutter/models/smartwatch.dart';

class BluetoothProvider {
  List<Smartwatch> smartwatches;

  BluetoothProvider({required this.smartwatches});

  Map<String, dynamic> toJson() => {
    'smartwatches': smartwatches.map((smartwatch) => smartwatch.toJson()).toList(),
  };

  factory BluetoothProvider.fromJson(Map<String, dynamic> json) {
    var list = json['smartwatches'] as List;
    List<Smartwatch> smartwatches = list.map((i) => Smartwatch.fromJson(i)).toList();
    return BluetoothProvider(smartwatches: smartwatches);
  }
}

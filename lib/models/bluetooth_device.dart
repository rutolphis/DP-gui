class BluetoothDevice {
  final String name;
  final String address;

  BluetoothDevice({required this.name, required this.address});

  // Method to convert a BLEDevice object to JSON
  Map<String, dynamic> toJson() => {
        'name': name,
        'address': address,
      };

  factory BluetoothDevice.fromJson(Map<String, dynamic> json) {
    return BluetoothDevice(
      name: json['name'] ?? 'Unknown',
      // Defaulting to 'Unknown' if name is not present
      address: json['address'],
    );
  }
}

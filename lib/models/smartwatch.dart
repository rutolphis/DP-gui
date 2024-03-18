class Smartwatch {
  String name;
  String address;
  int heartRate;

  Smartwatch({
    required this.name,
    required this.address,
    required this.heartRate,
  });

  // Method to convert Smartwatch object to JSON
  Map<String, dynamic> toJson() => {
    'name': name,
    'address': address,
    'heartRate': heartRate,
  };

  // Method to create a Smartwatch object from JSON
  factory Smartwatch.fromJson(Map<String, dynamic> json) {
    return Smartwatch(
      name: json['name'],
      address: json['address'],
      heartRate: json['heartRate'],
    );
  }
}

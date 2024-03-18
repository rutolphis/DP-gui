class CarStats {
  double speed; // Assuming speed is in kilometers per hour (km/h)
  double acceleration; // Assuming acceleration is in meters per second squared (m/s^2)
  double temperature; // Assuming temperature is in degrees Celsius

  CarStats({
    required this.speed,
    required this.acceleration,
    required this.temperature,
  });

  // Method to convert CarStats object to JSON
  Map<String, dynamic> toJson() => {
    'speed': speed,
    'acceleration': acceleration,
    'temperature': temperature,
  };

  // Method to create a CarStats object from JSON
  factory CarStats.fromJson(Map<String, dynamic> json) {
    return CarStats(
      speed: json['speed'].toDouble(),
      acceleration: json['acceleration'].toDouble(),
      temperature: json['temperature'].toDouble(),
    );
  }
}

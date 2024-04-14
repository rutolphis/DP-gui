class Address {
  String street;
  String city;
  String zipCode;
  String country;

  Address({
    required this.street,
    required this.city,
    required this.zipCode,
    required this.country,
  });

  Map<String, dynamic> toJson() => {
    'street': street,
    'city': city,
    'zipCode': zipCode,
    'country': country,
  };

  @override
  String toString() {
    return '$street, $city, $zipCode, $country';
  }

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street: json['street'],
      city: json['city'],
      zipCode: json['zipCode'],
      country: json['country'],
    );
  }
}

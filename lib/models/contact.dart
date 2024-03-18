class Contact {
  String name;
  String phone;

  Contact({
    required this.name,
    required this.phone,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'phone': phone,
  };

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      name: json['name'],
      phone: json['phone'],
    );
  }
}

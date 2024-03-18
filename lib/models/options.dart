class Options {
  bool option1;
  bool option2;
  bool option3;

  Options({
    required this.option1,
    required this.option2,
    required this.option3,
  });

  // Convert Options object to JSON
  Map<String, dynamic> toJson() => {
    'option1': option1,
    'option2': option2,
    'option3': option3,
  };

  // Create Options object from JSON
  factory Options.fromJson(Map<String, dynamic> json) {
    return Options(
      option1: json['option1'],
      option2: json['option2'],
      option3: json['option3'],
    );
  }
}

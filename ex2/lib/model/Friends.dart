class Friends {
  final String lastName;
  final String firstName;
  final double? latitude;
  final double? longtitude;

  Friends({
    required this.lastName,
    required this.firstName,
    required this.latitude,
    required this.longtitude,
  });

  factory Friends.fromJson(Map<String, dynamic> json) {
    return Friends(
      lastName: json["name"]["last"],
      firstName: json["name"]["first"],
      latitude: json["location"]["latitude"],
      longtitude: json["location"]["longtitude"],
    );
  }
}

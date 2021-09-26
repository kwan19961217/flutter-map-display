class Friend {
  final String lastName;
  final String firstName;
  final double latitude;
  final double longitude;

  Friend({
    required this.lastName,
    required this.firstName,
    required this.latitude,
    required this.longitude,
  });

  factory Friend.fromJson(Map<String, dynamic> json) {
    return Friend(
      lastName: json["name"]["last"] != null ? json["name"]["last"] : "",
      firstName: json["name"]["first"] != null ? json["name"]["first"] : "",
      latitude: json["location"]["latitude"] != null
          ? json["location"]["latitude"]
          : 0.0,
      longitude: json["location"]["longitude"] != null
          ? json["location"]["longitude"]
          : 0.0,
    );
  }
}

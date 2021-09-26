class Friend {
  final String _lastName;
  final String _firstName;
  final double _latitude;
  final double _longitude;

  Friend({
    lastName,
    firstName,
    latitude,
    longitude,
  })  : _lastName = lastName,
        _firstName = firstName,
        _latitude = latitude,
        _longitude = longitude;

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

  String get lastName => _lastName;

  String get firstName => _firstName;

  double get latitude => _latitude;

  double get longitude => _longitude;
}

class Location {
  final double latitud;
  final double longitud;

  const Location({required this.latitud, required this.longitud});

  double getLatitud() {
    return latitud;
  }

  double getLongitud() {
    return longitud;
  }

  factory Location.fromJson(Map<String, dynamic> json) =>
      Location(latitud: json['latitud'], longitud: json['longitud']);
}

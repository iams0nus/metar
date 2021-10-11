class Metar {
  final String reading;
  final String station;

  Metar({required this.reading, required this.station});

  factory Metar.fromJson(Map<String, dynamic> json) {
    return Metar(reading: json['reading'], station: json['station']);
  }
  factory Metar.fromError(Map<String, dynamic> json) {
    return Metar(reading: json['error'], station: json['station']);
  }
}

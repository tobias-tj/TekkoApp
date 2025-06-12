class UpdateMapDto {
  final int id;
  final String typeMap;
  final double latitude;
  final double longitude;
  final String token;

  UpdateMapDto({
    required this.id,
    required this.typeMap,
    required this.latitude,
    required this.longitude,
    required this.token,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'typeMap': typeMap,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}

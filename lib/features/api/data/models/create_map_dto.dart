class CreateMapDto {
  final String typeMap;
  final double latitude;
  final double longitude;
  final String token;

  CreateMapDto(
      {required this.typeMap,
      required this.latitude,
      required this.longitude,
      required this.token});

  Map<String, dynamic> toJson() {
    return {
      'typeMap': typeMap,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}

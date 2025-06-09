class GetMapsDto {
  final int id;
  final String typeMap;
  final double latitud;
  final double longitude;

  GetMapsDto(
      {required this.id,
      required this.typeMap,
      required this.latitud,
      required this.longitude});
}

import 'package:dio/dio.dart';
import 'package:tekko/features/api/data/models/create_list_map_dto.dart';
import 'package:tekko/features/api/data/models/get_maps_dto.dart';
import 'package:tekko/features/core/constants/api_constants.dart';

class MapsRemoteDatasource {
  final Dio dio;

  MapsRemoteDatasource({required this.dio});

  Future<void> createMapsDetails(CreateListMapDto createMap) async {
    try {
      final response = await dio.post(ApiConstants.createMapsDetails,
          data: createMap.toJson(),
          options: Options(headers: {
            'Authorization': 'Bearer ${createMap.maps[0].token}',
          }));

      if (response.statusCode == 201) {
        return;
      } else {
        throw Exception('Error al guardar detalles de la ubicacion');
      }
    } on DioException catch (e) {
      throw Exception(
        e.response?.data['message'] ??
            'Error de red al guardar detalles de la ubicacion',
      );
    }
  }

  Future<List<GetMapsDto>> getMapsDetails(String token) async {
    try {
      final response = await dio.get(ApiConstants.getMapsDetails,
          options: Options(headers: {
            'Authorization': 'Bearer ${token}',
          }));

      if (response.data['success'] == true) {
        final List<dynamic> dataList = response.data['data'];

        print('Se recupero correctamente los datos--> ${dataList}');

        return dataList
            .map((data) => GetMapsDto(
                id: data['id'] as int,
                typeMap: data['typeMap'],
                latitud: data['latitude'].toDouble(),
                longitude: data['longitude'].toDouble()))
            .toList();
      } else {
        throw Exception(response.data['message'] ?? 'Error desconocido');
      }
    } on DioException catch (e) {
      throw Exception(
          e.response?.data['message'] ?? 'Error obteniendo actividades');
    }
  }
}

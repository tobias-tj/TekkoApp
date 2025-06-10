import 'package:tekko/features/api/data/datasources/maps_remote_datasource.dart';
import 'package:tekko/features/api/data/models/create_list_map_dto.dart';
import 'package:tekko/features/api/data/models/get_maps_dto.dart';
import 'package:tekko/features/api/data/models/update_map_dto.dart';
import 'package:tekko/features/api/domain/repositories/map_repository.dart';

class MapRepositoryImpl implements MapRepository {
  final MapsRemoteDatasource remoteDatasource;

  MapRepositoryImpl({required this.remoteDatasource});

  @override
  Future<void> createMapInfo(CreateListMapDto mapDetails) async {
    try {
      return await remoteDatasource.createMapsDetails(mapDetails);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<GetMapsDto>> getMapInfo(String token) async {
    try {
      return await remoteDatasource.getMapsDetails(token);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateMapInfo(UpdateMapDto updateMapDetails) async {
    try {
      return await remoteDatasource.updateMapsDetails(updateMapDetails);
    } catch (e) {
      rethrow;
    }
  }
}

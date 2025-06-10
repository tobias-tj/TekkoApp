import 'package:tekko/features/api/data/models/create_list_map_dto.dart';
import 'package:tekko/features/api/data/models/get_maps_dto.dart';
import 'package:tekko/features/api/data/models/update_map_dto.dart';

abstract class MapRepository {
  Future<void> createMapInfo(CreateListMapDto mapDetails);
  Future<List<GetMapsDto>> getMapInfo(String token);
  Future<void> updateMapInfo(UpdateMapDto updateMapDetails);
}

import 'package:tekko/features/api/data/models/create_list_map_dto.dart';

abstract class MapRepository {
  Future<void> createMapInfo(CreateListMapDto mapDetails);
}

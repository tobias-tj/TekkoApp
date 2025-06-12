import 'package:tekko/features/api/data/models/create_list_map_dto.dart';
import 'package:tekko/features/api/domain/repositories/map_repository.dart';

class CreateMapInfoUseCases {
  final MapRepository repository;

  CreateMapInfoUseCases({required this.repository});

  Future<void> call(CreateListMapDto mapInfo) async {
    await repository.createMapInfo(mapInfo);
  }
}

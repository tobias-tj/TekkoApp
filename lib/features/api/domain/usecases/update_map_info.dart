import 'package:tekko/features/api/data/models/update_map_dto.dart';
import 'package:tekko/features/api/domain/repositories/map_repository.dart';

class UpdateMapInfoUseCases {
  final MapRepository repository;

  UpdateMapInfoUseCases({required this.repository});

  Future<void> call(UpdateMapDto updateMapInfo) async {
    await repository.updateMapInfo(updateMapInfo);
  }
}

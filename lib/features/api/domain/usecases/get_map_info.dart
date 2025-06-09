import 'package:tekko/features/api/data/models/get_maps_dto.dart';
import 'package:tekko/features/api/domain/repositories/map_repository.dart';

class GetMapInfoUseCases {
  final MapRepository repository;

  GetMapInfoUseCases({required this.repository});

  Future<List<GetMapsDto>> call(String token) async {
    return await repository.getMapInfo(token);
  }
}

import 'package:tekko/features/api/data/models/activity_kid_dto.dart';
import 'package:tekko/features/api/domain/repositories/kids_repository.dart';

class GetActivitiesByKidUseCases {
  final KidsRepository repository;

  GetActivitiesByKidUseCases({required this.repository});

  Future<List<ActivityKidDto>> call(String dateFilter, int kidId) async {
    return await repository.getActivitiesByKid(dateFilter, kidId);
  }
}

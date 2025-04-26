import 'package:tekko/features/api/data/models/filter_activity_dto.dart';
import 'package:tekko/features/api/domain/repositories/parent_repository.dart';

class GetActivitiesUseCases {
  final ParentRepository repository;

  GetActivitiesUseCases({required this.repository});

  Future<List<FilterActivityDto>> call(
      String dateFilter, String token, String? statusFilter) async {
    return await repository.getActivities(dateFilter, token, statusFilter);
  }
}

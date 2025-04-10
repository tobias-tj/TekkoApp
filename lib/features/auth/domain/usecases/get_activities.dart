import 'package:tekko/features/auth/data/models/filter_activity_dto.dart';
import 'package:tekko/features/auth/domain/repositories/parent_repository.dart';

class GetActivitiesUseCases {
  final ParentRepository repository;

  GetActivitiesUseCases({required this.repository});

  Future<List<FilterActivityDto>> call(
      String dateFilter, int parentId, String? statusFilter) async {
    return await repository.getActivities(dateFilter, parentId, statusFilter);
  }
}

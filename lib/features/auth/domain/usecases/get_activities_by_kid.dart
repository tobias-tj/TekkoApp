import 'package:tekko/features/auth/data/models/activity_kid_dto.dart';
import 'package:tekko/features/auth/data/models/filter_activity_dto.dart';
import 'package:tekko/features/auth/domain/repositories/kids_repository.dart';

class GetActivitiesByKidUseCases {
  final KidsRepository repository;

  GetActivitiesByKidUseCases({required this.repository});

  Future<List<ActivityKidDto>> call(String dateFilter, int kidId) async {
    return await repository.getActivitiesByKid(dateFilter, kidId);
  }
}

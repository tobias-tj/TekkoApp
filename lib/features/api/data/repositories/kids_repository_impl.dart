import 'package:tekko/features/api/data/datasources/kids_remote_datasource.dart';
import 'package:tekko/features/api/data/models/activity_kid_dto.dart';
import 'package:tekko/features/api/data/models/experience_dto.dart';
import 'package:tekko/features/api/domain/repositories/kids_repository.dart';

class KidsRepositoryImpl implements KidsRepository {
  final KidsRemoteDatasource remoteDataSource;

  KidsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ExperienceDto> getExperienceData(int childrenId) async {
    try {
      return await remoteDataSource.getExperienceData(childrenId);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ActivityKidDto>> getActivitiesByKid(
      String dateFilter, int kidId) async {
    try {
      return await remoteDataSource.getActivitiesByKid(dateFilter, kidId);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateActivity(int activityId) async {
    try {
      return await remoteDataSource.updateActivity(activityId);
    } catch (e) {
      rethrow;
    }
  }
}

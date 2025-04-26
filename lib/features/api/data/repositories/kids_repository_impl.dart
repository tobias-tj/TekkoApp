import 'package:tekko/features/api/data/datasources/kids_remote_datasource.dart';
import 'package:tekko/features/api/data/models/activity_kid_dto.dart';
import 'package:tekko/features/api/data/models/experience_dto.dart';
import 'package:tekko/features/api/data/models/update_task_status_dto.dart';
import 'package:tekko/features/api/domain/repositories/kids_repository.dart';

class KidsRepositoryImpl implements KidsRepository {
  final KidsRemoteDatasource remoteDataSource;

  KidsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ExperienceDto> getExperienceData(String token) async {
    try {
      return await remoteDataSource.getExperienceData(token);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ActivityKidDto>> getActivitiesByKid(
      String dateFilter, String token) async {
    try {
      return await remoteDataSource.getActivitiesByKid(dateFilter, token);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateActivity(int activityId, String token) async {
    try {
      return await remoteDataSource.updateActivity(activityId, token);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateTask(UpdateTaskStatusDto updateTask) async {
    try {
      return await remoteDataSource.updateTaskStatus(updateTask);
    } catch (e) {
      rethrow;
    }
  }
}

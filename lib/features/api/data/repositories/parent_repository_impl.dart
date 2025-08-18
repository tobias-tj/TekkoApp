import 'package:tekko/features/api/data/datasources/parent_remote_datasource.dart';
import 'package:tekko/features/api/data/models/create_task_model.dart';
import 'package:tekko/features/api/data/models/filter_activity_dto.dart';
import 'package:tekko/features/api/data/models/form_activity_model.dart';
import 'package:tekko/features/api/data/models/get_task_dto.dart';
import 'package:tekko/features/api/domain/repositories/parent_repository.dart';

class ParentRepositoryImpl implements ParentRepository {
  final ParentRemoteDatasource remoteDataSource;

  ParentRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Map<String, dynamic>> createActivity(
      FormActivityModel formActivityModel) async {
    return await remoteDataSource.createActivity(formActivityModel);
  }

  @override
  Future<List<FilterActivityDto>> getActivities(
      String dateFilter, String token, String? statusFilter) async {
    return await remoteDataSource.getActivities(
        dateFilter, token, statusFilter);
  }

  @override
  Future<Map<String, dynamic>> createTask(
      CreateTaskModel createTaskModel) async {
    return await remoteDataSource.createTask(createTaskModel);
  }

  @override
  Future<GetTaskDto> getTasks(String token) async {
    return await remoteDataSource.getTasks(token);
  }

  @override
  Future<void> deleteTaskByKid(String token) async {
    return await remoteDataSource.deleteTaskByKid(token);
  }
}

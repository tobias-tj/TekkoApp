import 'package:tekko/features/api/data/datasources/parent_remote_datasource.dart';
import 'package:tekko/features/api/data/models/filter_activity_dto.dart';
import 'package:tekko/features/api/data/models/form_activity_model.dart';
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
      String dateFilter, int parentId, String? statusFilter) async {
    return await remoteDataSource.getActivities(
        dateFilter, parentId, statusFilter);
  }
}

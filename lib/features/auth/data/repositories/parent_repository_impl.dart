import 'package:tekko/features/auth/data/datasources/parent_remote_datasource.dart';
import 'package:tekko/features/auth/data/models/form_activity_model.dart';
import 'package:tekko/features/auth/domain/repositories/parent_repository.dart';

class ParentRepositoryImpl implements ParentRepository {
  final ParentRemoteDatasource remoteDataSource;

  ParentRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Map<String, dynamic>> createActivity(
      FormActivityModel formActivityModel) async {
    return await remoteDataSource.createActivity(formActivityModel);
  }
}

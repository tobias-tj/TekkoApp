import 'package:tekko/features/api/data/datasources/setting_remote_datasource.dart';
import 'package:tekko/features/api/data/models/details_profile_dto.dart';
import 'package:tekko/features/api/data/models/update_profile_dto.dart';
import 'package:tekko/features/api/domain/repositories/setting_repository.dart';

class SettingRepositoryImpl implements SettingRepository {
  final SettingRemoteDatasource remoteDataSource;

  SettingRepositoryImpl({required this.remoteDataSource});

  @override
  Future<DetailsProfileDto> getProfileDetails(
      int parentId, int childrenId) async {
    return await remoteDataSource.getProfileDetails(parentId, childrenId);
  }

  @override
  Future<void> updateProfile(UpdateProfileDto updatedProfile) async {
    return await remoteDataSource.updateProfile(updatedProfile);
  }
}

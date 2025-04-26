import 'package:tekko/features/api/data/datasources/setting_remote_datasource.dart';
import 'package:tekko/features/api/data/models/details_profile_dto.dart';
import 'package:tekko/features/api/data/models/update_profile_dto.dart';
import 'package:tekko/features/api/domain/repositories/setting_repository.dart';

class SettingRepositoryImpl implements SettingRepository {
  final SettingRemoteDatasource remoteDataSource;

  SettingRepositoryImpl({required this.remoteDataSource});

  @override
  Future<DetailsProfileDto> getProfileDetails(String token) async {
    return await remoteDataSource.getProfileDetails(token);
  }

  @override
  Future<void> updateProfile(UpdateProfileDto updatedProfile) async {
    return await remoteDataSource.updateProfile(updatedProfile);
  }

  @override
  Future<void> updatePin(String token, String pinToken, String oldToken) async {
    return await remoteDataSource.updatePinToken(token, pinToken, oldToken);
  }
}

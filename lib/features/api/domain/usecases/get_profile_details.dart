import 'package:tekko/features/api/data/models/details_profile_dto.dart';
import 'package:tekko/features/api/domain/repositories/setting_repository.dart';

class GetProfileDetailsUseCases {
  final SettingRepository repository;

  GetProfileDetailsUseCases({required this.repository});

  Future<DetailsProfileDto> call(String token) async {
    return await repository.getProfileDetails(token);
  }
}

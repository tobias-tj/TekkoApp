import 'package:tekko/features/api/data/models/update_profile_dto.dart';
import 'package:tekko/features/api/domain/repositories/setting_repository.dart';

class UpdateProfileUseCases {
  final SettingRepository repository;

  UpdateProfileUseCases({required this.repository});

  Future<void> call(UpdateProfileDto updatedProfile) async {
    await repository.updateProfile(updatedProfile);
  }
}

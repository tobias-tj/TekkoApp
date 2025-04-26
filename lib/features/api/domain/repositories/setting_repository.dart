import 'package:tekko/features/api/data/models/details_profile_dto.dart';
import 'package:tekko/features/api/data/models/update_profile_dto.dart';

abstract class SettingRepository {
  Future<DetailsProfileDto> getProfileDetails(String token);
  Future<void> updateProfile(UpdateProfileDto updatedProfile);
  Future<void> updatePin(String token, String pinToken, String oldToken);
}

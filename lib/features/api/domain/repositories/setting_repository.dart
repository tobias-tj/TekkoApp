import 'package:tekko/features/api/data/models/details_profile_dto.dart';
import 'package:tekko/features/api/data/models/update_profile_dto.dart';

abstract class SettingRepository {
  Future<DetailsProfileDto> getProfileDetails(int parentId, int childrenId);
  Future<void> updateProfile(UpdateProfileDto updatedProfile);
}

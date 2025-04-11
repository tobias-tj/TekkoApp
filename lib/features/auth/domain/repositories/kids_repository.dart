import 'package:tekko/features/auth/data/models/activity_kid_dto.dart';
import 'package:tekko/features/auth/data/models/experience_dto.dart';

abstract class KidsRepository {
  Future<ExperienceDto> getExperienceData(int childrenId);
  Future<List<ActivityKidDto>> getActivitiesByKid(String dateFilter, int kidId);
}

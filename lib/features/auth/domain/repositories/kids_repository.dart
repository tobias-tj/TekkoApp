import 'package:tekko/features/auth/data/models/experience_dto.dart';

abstract class KidsRepository {
  Future<ExperienceDto> getExperienceData(int childrenId);
}

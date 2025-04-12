import 'package:tekko/features/api/data/models/experience_dto.dart';
import 'package:tekko/features/api/domain/repositories/kids_repository.dart';

class GetExperience {
  final KidsRepository repository;

  GetExperience(this.repository);

  Future<ExperienceDto> execute(int childrenId) async {
    return await repository.getExperienceData(childrenId);
  }
}

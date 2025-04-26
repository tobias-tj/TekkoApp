import 'package:tekko/features/api/data/models/experience_dto.dart';
import 'package:tekko/features/api/domain/repositories/kids_repository.dart';

class GetExperience {
  final KidsRepository repository;

  GetExperience(this.repository);

  Future<ExperienceDto> execute(String token) async {
    return await repository.getExperienceData(token);
  }
}

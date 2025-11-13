import 'package:tekko/features/api/domain/repositories/kids_repository.dart';

class UpdateExperience {
  final KidsRepository repository;

  UpdateExperience(this.repository);

  Future<void> execute(String token, int newExp) async {
    return await repository.updateExperienceData(token, newExp);
  }
}

import 'package:tekko/features/api/domain/repositories/kids_repository.dart';

class UpdateActivityUseCases {
  final KidsRepository repository;

  UpdateActivityUseCases({required this.repository});

  Future<void> call(int activityId) async {
    await repository.updateActivity(activityId);
  }
}

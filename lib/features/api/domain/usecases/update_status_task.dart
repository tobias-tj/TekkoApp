import 'package:tekko/features/api/data/models/update_task_status_dto.dart';
import 'package:tekko/features/api/domain/repositories/kids_repository.dart';

class UpdateStatusTask {
  final KidsRepository repository;

  UpdateStatusTask({required this.repository});

  Future<void> call(UpdateTaskStatusDto updateTask) async {
    await repository.updateTask(updateTask);
  }
}

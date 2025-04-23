import 'package:tekko/features/api/data/models/create_task_model.dart';
import 'package:tekko/features/api/domain/repositories/parent_repository.dart';

class CreateTaskUseCases {
  final ParentRepository repository;

  CreateTaskUseCases({required this.repository});

  Future<Map<String, dynamic>> call(CreateTaskModel model) async {
    return await repository.createTask(model);
  }
}

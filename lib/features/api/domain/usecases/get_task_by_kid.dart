import 'package:tekko/features/api/data/models/get_task_dto.dart';
import 'package:tekko/features/api/domain/repositories/parent_repository.dart';

class GetTaskByKidUseCases {
  final ParentRepository repository;

  GetTaskByKidUseCases({required this.repository});

  Future<GetTaskDto> call(int childrenId) async {
    return await repository.getTasks(childrenId);
  }
}

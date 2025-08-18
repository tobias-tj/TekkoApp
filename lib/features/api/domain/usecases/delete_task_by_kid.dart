import 'package:tekko/features/api/domain/repositories/parent_repository.dart';

class DeleteTaskByKidUseCases {
  final ParentRepository repository;

  DeleteTaskByKidUseCases({required this.repository});

  Future<void> call(String token) async {
    return await repository.deleteTaskByKid(token);
  }
}

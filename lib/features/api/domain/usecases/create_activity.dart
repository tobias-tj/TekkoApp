import 'package:tekko/features/api/data/models/form_activity_model.dart';
import 'package:tekko/features/api/domain/repositories/parent_repository.dart';

class CreateActivityUseCases {
  final ParentRepository repository;

  CreateActivityUseCases({required this.repository});

  Future<Map<String, dynamic>> call(FormActivityModel model) async {
    return await repository.createActivity(model);
  }
}

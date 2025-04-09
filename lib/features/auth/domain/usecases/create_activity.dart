import 'package:tekko/features/auth/data/models/form_activity_model.dart';
import 'package:tekko/features/auth/domain/repositories/parent_repository.dart';

class CreateActivityUseCases {
  final ParentRepository repository;

  CreateActivityUseCases({required this.repository});

  Future<Map<String, dynamic>> call(FormActivityModel model) async {
    return await repository.createActivity(model);
  }
}

import 'package:tekko/features/auth/data/models/auth_model.dart';
import 'package:tekko/features/auth/domain/repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase({required this.repository});

  Future<Map<String, dynamic>> call(AuthModel authModel) async {
    return await repository.register(authModel);
  }
}

import 'package:tekko/features/api/data/models/login_model.dart';
import 'package:tekko/features/api/domain/repositories/auth_repository.dart';

class LoginUsecase {
  final AuthRepository repository;

  LoginUsecase({required this.repository});

  Future<Map<String, dynamic>> call(LoginModel loginModel) async {
    return await repository.login(loginModel);
  }
}

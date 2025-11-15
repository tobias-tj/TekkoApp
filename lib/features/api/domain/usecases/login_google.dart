import 'package:tekko/features/api/domain/repositories/auth_repository.dart';

class LoginGoogle {
  final AuthRepository repository;
  LoginGoogle({required this.repository});

  Future<Map<String, dynamic>> call(String googleToken) async {
    return await repository.loginWithGoogle(googleToken);
  }
}

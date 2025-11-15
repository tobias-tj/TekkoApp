import 'package:tekko/features/api/domain/repositories/auth_repository.dart';

class RegisterGoogle {
  final AuthRepository repository;

  RegisterGoogle({required this.repository});

  Future<Map<String, dynamic>> call(String googleToken) async {
    return await repository.registerWithGoogle(googleToken);
  }
}

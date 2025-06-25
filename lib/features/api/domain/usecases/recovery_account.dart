import 'package:tekko/features/api/domain/repositories/auth_repository.dart';

class RecoveryAccount {
  final AuthRepository repository;

  RecoveryAccount({required this.repository});

  Future<void> call(String email) async {
    await repository.recoveryAccount(email);
  }
}

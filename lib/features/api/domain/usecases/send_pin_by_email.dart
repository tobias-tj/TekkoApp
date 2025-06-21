import 'package:tekko/features/api/domain/repositories/auth_repository.dart';

class SendPinByEmail {
  final AuthRepository authRepository;

  SendPinByEmail({required this.authRepository});

  Future<void> call(String token) async {
    await authRepository.sendPinByEmail(token);
  }
}

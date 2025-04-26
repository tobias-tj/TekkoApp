import 'package:tekko/features/api/domain/repositories/setting_repository.dart';

class UpdatePinUseCases {
  final SettingRepository repository;

  UpdatePinUseCases({required this.repository});

  Future<void> call(String token, String pinToken, String oldToken) async {
    await repository.updatePin(token, pinToken, oldToken);
  }
}

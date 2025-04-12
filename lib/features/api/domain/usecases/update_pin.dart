import 'package:tekko/features/api/domain/repositories/setting_repository.dart';

class UpdatePinUseCases {
  final SettingRepository repository;

  UpdatePinUseCases({required this.repository});

  Future<void> call(int parentId, String pinToken, String oldToken) async {
    await repository.updatePin(parentId, pinToken, oldToken);
  }
}

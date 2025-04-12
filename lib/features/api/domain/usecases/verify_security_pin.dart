import 'package:tekko/features/api/data/models/security_model.dart';
import 'package:tekko/features/api/domain/repositories/auth_repository.dart';

class VerifySecurityPinUseCase {
  final AuthRepository repository;

  VerifySecurityPinUseCase({required this.repository});

  Future<Map<String, dynamic>> call(SecurityModel securityModel) async {
    try {
      final response = await repository.accessParentPin(securityModel);
      return response;
    } catch (e) {
      print('Error in VerifySecurityPinUseCase: $e');
      rethrow;
    }
  }
}

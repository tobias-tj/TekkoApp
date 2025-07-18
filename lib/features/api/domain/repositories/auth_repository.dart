import 'package:tekko/features/api/data/models/auth_model.dart';
import 'package:tekko/features/api/data/models/login_model.dart';
import 'package:tekko/features/api/data/models/security_model.dart';

abstract class AuthRepository {
  Future<Map<String, dynamic>> register(AuthModel authModel);
  Future<Map<String, dynamic>> login(LoginModel loginModel);
  Future<Map<String, dynamic>> accessParentPin(SecurityModel securityModel);
  Future<void> recoveryAccount(String email);
  Future<void> sendPinByEmail(String token);
}

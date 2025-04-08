import 'package:tekko/features/auth/data/models/auth_model.dart';
import 'package:tekko/features/auth/data/models/login_model.dart';
import 'package:tekko/features/auth/data/models/security_model.dart';

abstract class AuthRepository {
  Future<Map<String, dynamic>> register(AuthModel authModel);
  Future<Map<String, dynamic>> login(LoginModel loginModel);
  Future<Map<String, dynamic>> accessParentPin(SecurityModel securityModel);
}

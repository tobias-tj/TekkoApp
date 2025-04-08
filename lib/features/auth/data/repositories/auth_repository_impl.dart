import 'package:tekko/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:tekko/features/auth/data/models/auth_model.dart';
import 'package:tekko/features/auth/data/models/login_model.dart';
import 'package:tekko/features/auth/data/models/security_model.dart';
import 'package:tekko/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Map<String, dynamic>> register(AuthModel authModel) async {
    return await remoteDataSource.register(authModel);
  }

  @override
  Future<Map<String, dynamic>> login(LoginModel loginModel) async {
    return await remoteDataSource.login(loginModel);
  }

  @override
  Future<Map<String, dynamic>> accessParentPin(
      SecurityModel securityModel) async {
    return await remoteDataSource.accessParentPin(securityModel);
  }
}

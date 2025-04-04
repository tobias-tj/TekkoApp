import 'package:dio/dio.dart';
import 'package:tekko/features/auth/data/models/auth_model.dart';
import 'package:tekko/features/auth/data/models/login_model.dart';
import 'package:tekko/features/core/constants/api_constants.dart';

class AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSource({required this.dio});

  Future<Map<String, dynamic>> register(AuthModel authModel) async {
    try {
      final response = await dio.post(
        ApiConstants.registerEndpoint,
        data: authModel.toJson(),
      );
      return {
        'parentId': response.data['data']['parentId'],
        'childrenId': response.data['data']['childrenId'],
      };
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Error en el registro');
    }
  }

  Future<Map<String, dynamic>> login(LoginModel loginModel) async {
    try {
      final response = await dio.get(
        ApiConstants.loginEndpoint,
        data: loginModel.toJson(),
      );
      return {
        'parentId': response.data['data']['parentId'],
        'childrenId': response.data['data']['childrenId'],
      };
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Error en el login');
    }
  }
}

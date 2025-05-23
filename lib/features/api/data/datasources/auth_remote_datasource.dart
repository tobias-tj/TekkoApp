import 'package:dio/dio.dart';
import 'package:tekko/features/api/data/models/auth_model.dart';
import 'package:tekko/features/api/data/models/login_model.dart';
import 'package:tekko/features/api/data/models/security_model.dart';
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
        'token': response.data['data']['token'],
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
        'token': response.data['data']['token'],
      };
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Error en el login');
    }
  }

  Future<Map<String, dynamic>> accessParentPin(
      SecurityModel securityModel) async {
    try {
      final response = await dio.post(
        ApiConstants.pinEndpoint,
        data: securityModel.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer ${securityModel.token}',
          },
        ),
      );

      return {
        'success': response.data['success'],
        'fullName': response.data['parentInfo']['fullName']
      };
    } on DioException catch (e) {
      throw Exception(
          e.response?.data['message'] ?? 'Error con el pin ingresado');
    }
  }
}

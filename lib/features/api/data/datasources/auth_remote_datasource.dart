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

  Future<void> recoveryAccount(String email) async {
    try {
      final response = await dio.post(
        ApiConstants.recoverAccountEndpoint,
        data: {'emailAccount': email},
      );

      if (response.statusCode == 201) {
        return;
      } else {
        throw Exception('Error al recuperar la cuenta');
      }
    } on DioException catch (e) {
      final responseData = e.response?.data;

      if (responseData != null &&
          responseData['errors'] is List &&
          responseData['errors'].isNotEmpty) {
        final firstError = responseData['errors'][0];
        final message = firstError['msg'] ?? 'Error desconocido';
        throw Exception(message);
      }

      throw Exception('Error de red al actualizar la actividad');
    }
  }

  Future<void> sendPinByEmail(String token) async {
    try {
      final response = await dio.post(
        ApiConstants.sendPinByEmailEndpoint,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 201) {
        return;
      } else {
        throw Exception('Error al enviar el PIN por correo electrónico');
      }
    } on DioException catch (e) {
      final data = e.response?.data;

      String errorMessage = 'Error desconocido al enviar el PIN';

      if (data is Map<String, dynamic>) {
        if (data.containsKey('error')) {
          errorMessage = data['error'];
        } else if (data.containsKey('message')) {
          errorMessage = data['message'];
        } else if (data.containsKey('errors') && data['errors'] is List) {
          final List errorsList = data['errors'];
          errorMessage = errorsList.map((e) => e['msg']).join('\n');
        }
      }

      throw Exception(errorMessage);
    }
  }
}

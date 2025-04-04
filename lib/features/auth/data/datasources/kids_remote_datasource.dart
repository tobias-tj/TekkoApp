import 'package:dio/dio.dart';
import 'package:tekko/features/auth/data/models/experience_dto.dart';
import 'package:tekko/features/core/constants/api_constants.dart';

class KidsRemoteDatasource {
  final Dio dio;

  KidsRemoteDatasource({required this.dio});

  Future<ExperienceDto> getExperienceData(int childrenId) async {
    try {
      final response = await dio.get(
        '${ApiConstants.experienceEndpoint}/?childrenId=$childrenId',
      );

      if (response.data['success'] == true) {
        final data = response.data['data'];
        return ExperienceDto(
          fullName: data['fullName'],
          exp: data['exp'],
          level: data['level'],
          expNextlevel: data['expNextLevel'],
          nextLevel: data['nextLevel'],
        );
      } else {
        throw Exception(response.data['message'] ?? 'Error desconocido');
      }
    } on DioException catch (e) {
      throw Exception(
        e.response?.data['message'] ?? 'Error al obtener experiencia',
      );
    }
  }
}

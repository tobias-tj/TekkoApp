import 'package:dio/dio.dart';
import 'package:tekko/features/api/data/models/activity_kid_dto.dart';
import 'package:tekko/features/api/data/models/experience_dto.dart';
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

  Future<List<ActivityKidDto>> getActivitiesByKid(
      String dateFilter, int kidId) async {
    try {
      final response = await dio.get(
        '${ApiConstants.getActivityKidEndpoint}/?dateFilter=$dateFilter&kidId=$kidId',
      );

      if (response.data['success'] == true) {
        final List<dynamic> dataList = response.data['data'];

        return dataList
            .map((data) => ActivityKidDto(
                  activityDetailId: data['activity_detail_id'] as int,
                  startActivityTime: data['start_activity_time'] as String,
                  expirationActivityTime:
                      data['expiration_activity_time'] as String,
                  titleActivity: data['title_activity'] as String,
                  descriptionActivity: data['description_activity'] as String,
                  experienceActivity: data['experience_activity'] as int,
                  activityId: data['activity_id'] as int,
                  status: data['status'] as String,
                ))
            .toList();
      } else {
        throw Exception(response.data['message'] ?? 'Error desconocido');
      }
    } on DioException catch (e) {
      throw Exception(
        e.response?.data['message'] ?? 'Error al obtener experiencia',
      );
    }
  }

  Future<void> updateActivity(int activityId) async {
    try {
      final response = await dio.put(
        ApiConstants.updateActivity,
        data: {
          'activityId': activityId,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        final data = response.data;

        if (data != null && data['data'] == 'Actividad actualizado con Exito') {
          return;
        } else {
          throw Exception('Respuesta inesperada del servidor');
        }
      } else {
        throw Exception('Error al actualizar la actividad');
      }
    } on DioException catch (e) {
      throw Exception(
        e.response?.data['message'] ??
            'Error de red al actualizar la actividad',
      );
    }
  }
}

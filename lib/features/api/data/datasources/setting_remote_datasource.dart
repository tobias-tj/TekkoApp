import 'package:dio/dio.dart';
import 'package:tekko/features/api/data/models/details_profile_dto.dart';
import 'package:tekko/features/api/data/models/update_profile_dto.dart';
import 'package:tekko/features/core/constants/api_constants.dart';

class SettingRemoteDatasource {
  final Dio dio;

  SettingRemoteDatasource({required this.dio});

  Future<DetailsProfileDto> getProfileDetails(String token) async {
    try {
      final response = await dio.get(
        ApiConstants.getProfileDetails,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.data['success'] == true) {
        final data = response.data['data'];

        final detail = DetailsProfileDto(
            parentName: data['parent_name'],
            childName: data['childName'],
            email: data['email'],
            age: data['age'],
            totalActivitiesCreatedByParent: int.tryParse(
                    data['total_activities_created_by_parent'].toString()) ??
                0,
            totalCompletedActivitiesByChild: int.tryParse(
                    data['total_completed_activities_by_child'].toString()) ??
                0);

        return detail;
      } else {
        throw Exception(response.data['message'] ?? 'Error desconocido');
      }
    } on DioException catch (e) {
      throw Exception(
        e.response?.data['message'] ?? 'Error al obtener experiencia',
      );
    }
  }

  Future<void> updateProfile(UpdateProfileDto updatedProfile) async {
    try {
      final response = await dio.put(
        ApiConstants.updateProfileDetails,
        data: updatedProfile.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer ${updatedProfile.token}',
          },
        ),
      );

      if (response.data['success'] == true) {
        return;
      } else {
        throw Exception(response.data['message'] ?? 'Error desconocido');
      }
    } on DioException catch (e) {
      throw Exception(
        e.response?.data['message'] ?? 'Error al obtener experiencia',
      );
    }
  }

  Future<void> updatePinToken(
      String token, String pinToken, String oldToken) async {
    try {
      final response = await dio.put(
        ApiConstants.updatePinToken,
        data: {
          'pinToken': pinToken,
          'oldToken': oldToken,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.data['success'] == true) {
        return;
      } else {
        throw response.data['message'] ??
            'Error desconocido al actualizar el PIN';
      }
    } on DioException catch (e) {
      final errorMessage = e.response?.data['message'] ??
          'Error al actualizar el PIN. Pin Invalido!';
      throw errorMessage; // Lanza directamente el String, no una Exception
    }
  }
}

import 'package:dio/dio.dart';
import 'package:tekko/features/api/data/models/filter_activity_dto.dart';
import 'package:tekko/features/api/data/models/form_activity_model.dart';
import 'package:tekko/features/core/constants/api_constants.dart';

class ParentRemoteDatasource {
  final Dio dio;

  ParentRemoteDatasource({required this.dio});

  Future<Map<String, dynamic>> createActivity(FormActivityModel model) async {
    try {
      final response = await dio.post(
        ApiConstants.createActivityEndpoint,
        data: model.toJson(),
      );

      return {
        'message': response.data['message'],
        'activityId': response.data['data']['activityId'],
        'activityDetailId': response.data['data']['activityDetailId'],
      };
    } on DioException catch (e) {
      throw Exception(
          e.response?.data['message'] ?? 'Error intentando crear actividad');
    }
  }

  Future<List<FilterActivityDto>> getActivities(
      String dateFilter, int parentId, String? statusFilter) async {
    try {
      final response = await dio.get(statusFilter != null
          ? '${ApiConstants.getActivityEndpoint}/?dateFilter=$dateFilter&parentId=$parentId&statusFilter=$statusFilter'
          : '${ApiConstants.getActivityEndpoint}/?dateFilter=$dateFilter&parentId=$parentId');

      if (response.data['success'] == true) {
        final List<dynamic> dataList = response.data['data'];

        return dataList
            .map((data) => FilterActivityDto(
                  activityDetailId: data['activity_detail_id'] as int,
                  startActivityTime: data['start_activity_time'] as String,
                  expirationActivityTime:
                      data['expiration_activity_time'] as String,
                  titleActivity: data['title_activity'] as String,
                  descriptionActivity: data['description_activity'] as String,
                  experienceActivity: data['experience_activity'] as int,
                  activityId: data['activity_id'] as int,
                  childrenId: data['children_id'] as int,
                  parentId: data['parent_id'] as int,
                  status: data['status'] as String,
                ))
            .toList();
      } else {
        throw Exception(response.data['message'] ?? 'Error desconocido');
      }
    } on DioException catch (e) {
      throw Exception(
          e.response?.data['message'] ?? 'Error obteniendo actividades');
    }
  }
}

import 'package:dio/dio.dart';
import 'package:tekko/features/auth/data/models/form_activity_model.dart';
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
}

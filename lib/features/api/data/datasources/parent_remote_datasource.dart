import 'package:dio/dio.dart';
import 'package:tekko/features/api/data/models/create_task_model.dart';
import 'package:tekko/features/api/data/models/filter_activity_dto.dart';
import 'package:tekko/features/api/data/models/form_activity_model.dart';
import 'package:tekko/features/api/data/models/get_task_dto.dart';
import 'package:tekko/features/core/constants/api_constants.dart';

class ParentRemoteDatasource {
  final Dio dio;

  ParentRemoteDatasource({required this.dio});

  Future<Map<String, dynamic>> createActivity(FormActivityModel model) async {
    try {
      final response = await dio.post(
        ApiConstants.createActivityEndpoint,
        data: model.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer ${model.token}',
          },
        ),
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
      String dateFilter, String token, String? statusFilter) async {
    try {
      final response = await dio.get(
          statusFilter != null
              ? ('${ApiConstants.getActivityEndpoint}/?dateFilter=$dateFilter&statusFilter=$statusFilter')
              : ('${ApiConstants.getActivityEndpoint}/?dateFilter=$dateFilter'),
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ));

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

  Future<Map<String, dynamic>> createTask(
      CreateTaskModel createTaskModel) async {
    try {
      final response = await dio.post(
        ApiConstants.createTasksEndpoint,
        data: createTaskModel.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer ${createTaskModel.token}',
          },
        ),
      );

      return {
        'message': response.data['message'],
        'taskId': response.data['data']['taskId']
      };
    } on DioException catch (e) {
      throw Exception(
          e.response?.data['message'] ?? 'Error intentando crear tarea');
    }
  }

  Future<GetTaskDto> getTasks(String token) async {
    try {
      final response = await dio.get(
        ApiConstants.getTaskByKid,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.data['success'] == true) {
        final data = response.data['data'];

        final int pendingTasks = data['pendingTasks'];
        final List<Tasks> tasks = (data['tasks'] as List).map((task) {
          return Tasks(
            taskid: int.parse(task['taskid'].toString()),
            number1: int.parse(task['number1'].toString()),
            number2: int.parse(task['number2'].toString()),
            operation: task['operation'],
            correctanswer: int.parse(task['correctanswer'].toString()),
            iscompleted: task['iscompleted'],
            childanswer: task['childanswer'] != null
                ? int.tryParse(task['childanswer'].toString())
                : null,
          );
        }).toList();

        return GetTaskDto(pendingTasks: pendingTasks, taskList: tasks);
      } else {
        throw Exception(response.data['message'] ?? 'Error desconocido');
      }
    } on DioException catch (e) {
      throw Exception(
          e.response?.data['message'] ?? 'No se ha logrado obtener las tareas');
    }
  }

  Future<void> deleteTaskByKid(String token) async {
    try {
      final response = await dio.delete(
        ApiConstants.deleteTaskByKid,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.data['success'] != true) {
        throw Exception(
            response.data['message'] ?? 'Error al eliminar la tarea');
      }
    } on DioException catch (e) {
      throw Exception(
          e.response?.data['message'] ?? 'Error al eliminar la tarea');
    }
  }
}

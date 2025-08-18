import 'package:tekko/features/api/data/models/create_task_model.dart';
import 'package:tekko/features/api/data/models/filter_activity_dto.dart';
import 'package:tekko/features/api/data/models/form_activity_model.dart';
import 'package:tekko/features/api/data/models/get_task_dto.dart';

abstract class ParentRepository {
  Future<Map<String, dynamic>> createActivity(
      FormActivityModel formActivityModel);
  Future<List<FilterActivityDto>> getActivities(
      String dateFilter, String token, String? statusFilter);
  Future<Map<String, dynamic>> createTask(CreateTaskModel createTaskModel);
  Future<GetTaskDto> getTasks(String token);
  Future<void> deleteTaskByKid(String token);
}

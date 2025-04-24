import 'package:tekko/features/api/data/models/activity_kid_dto.dart';
import 'package:tekko/features/api/data/models/experience_dto.dart';
import 'package:tekko/features/api/data/models/update_task_status_dto.dart';

abstract class KidsRepository {
  Future<ExperienceDto> getExperienceData(int childrenId);
  Future<List<ActivityKidDto>> getActivitiesByKid(String dateFilter, int kidId);
  Future<void> updateActivity(int activityId);
  Future<void> updateTask(UpdateTaskStatusDto updateTask);
}

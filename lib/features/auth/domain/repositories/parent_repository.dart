import 'package:tekko/features/auth/data/models/filter_activity_dto.dart';
import 'package:tekko/features/auth/data/models/form_activity_model.dart';

abstract class ParentRepository {
  Future<Map<String, dynamic>> createActivity(
      FormActivityModel formActivityModel);
  Future<List<FilterActivityDto>> getActivities(
      String dateFilter, int parentId, String? statusFilter);
}

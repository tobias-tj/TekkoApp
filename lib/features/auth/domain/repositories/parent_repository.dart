import 'package:tekko/features/auth/data/models/form_activity_model.dart';

abstract class ParentRepository {
  Future<Map<String, dynamic>> createActivity(
      FormActivityModel formActivityModel);
}

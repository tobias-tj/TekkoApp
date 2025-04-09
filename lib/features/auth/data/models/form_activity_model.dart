class FormActivityModel {
  final Detail detail;
  final int childrenId;
  final int parentId;

  FormActivityModel({
    required this.detail,
    required this.childrenId,
    required this.parentId,
  });

  Map<String, dynamic> toJson() => {
        'detail': detail.toJson(),
        'children_id': childrenId,
        'parent_id': parentId,
      };
}

class Detail {
  final DateTime startActivityTime;
  final DateTime expirationActivityTime;
  final String titleActivity;
  final String descriptionActivity;
  final int experienceActivity;

  Detail({
    required this.startActivityTime,
    required this.expirationActivityTime,
    required this.titleActivity,
    required this.descriptionActivity,
    required this.experienceActivity,
  });

  Map<String, dynamic> toJson() => {
        'start_activity_time': startActivityTime.toIso8601String(),
        'expiration_activity_time': expirationActivityTime.toIso8601String(),
        'title_activity': titleActivity,
        'description_activity': descriptionActivity,
        'experience_activity': experienceActivity,
      };
}

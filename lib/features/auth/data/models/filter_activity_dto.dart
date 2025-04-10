class FilterActivityDto {
  final int activityDetailId;
  final String startActivityTime;
  final String expirationActivityTime;
  final String titleActivity;
  final String descriptionActivity;
  final int experienceActivity;
  final int activityId;
  final int childrenId;
  final int parentId;
  final String status;

  FilterActivityDto(
      {required this.activityDetailId,
      required this.startActivityTime,
      required this.expirationActivityTime,
      required this.titleActivity,
      required this.descriptionActivity,
      required this.experienceActivity,
      required this.activityId,
      required this.childrenId,
      required this.parentId,
      required this.status});

  Map<String, dynamic> toJson() => {
        'activity_detail_id': activityDetailId,
        'start_activity_time': startActivityTime,
        'expiration_activity_time': expirationActivityTime,
        'title_activity': titleActivity,
        'description_activity': descriptionActivity,
        'experience_activity': experienceActivity,
        'activity_id': activityId,
        'children_id': childrenId,
        'parent_id': parentId,
        'status': status
      };
}

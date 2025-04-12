class DetailsProfileDto {
  final String parentName;
  final String childName;
  final String email;
  final int age;
  final int totalActivitiesCreatedByParent;
  final int totalCompletedActivitiesByChild;

  DetailsProfileDto({
    required this.parentName,
    required this.childName,
    required this.email,
    required this.age,
    required this.totalActivitiesCreatedByParent,
    required this.totalCompletedActivitiesByChild,
  });

  Map<String, dynamic> toJson() => {
        'parent_name': parentName,
        'childName': childName,
        'email': email,
        'age': age,
        'total_activities_created_by_parent': totalActivitiesCreatedByParent,
        'total_completed_activities_by_child': totalCompletedActivitiesByChild
      };
}

class UpdateTaskStatusDto {
  final String token;
  final int childAnswer;
  final int taskId;

  UpdateTaskStatusDto(
      {required this.token, required this.childAnswer, required this.taskId});

  Map<String, dynamic> toJson() =>
      {'childAnswer': childAnswer, 'taskId': taskId};
}

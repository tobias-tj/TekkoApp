class GetTaskDto {
  final int pendingTasks;
  final List<Tasks> taskList;

  GetTaskDto({required this.pendingTasks, required this.taskList});
}

class Tasks {
  final int taskid;
  final int number1;
  final int number2;
  final String operation;
  final int correctanswer;
  final bool iscompleted;
  final int? childanswer;

  Tasks(
      {required this.taskid,
      required this.number1,
      required this.number2,
      required this.operation,
      required this.correctanswer,
      required this.iscompleted,
      this.childanswer});
}

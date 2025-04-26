part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class TaskRequested extends TaskEvent {
  final CreateTaskModel taskModel;

  const TaskRequested({required this.taskModel});

  @override
  List<Object> get props => [taskModel];
}

class TaskGetRequested extends TaskEvent {
  final String token;

  const TaskGetRequested({required this.token});

  @override
  List<Object> get props => [token];
}

class TaskUpdateRequested extends TaskEvent {
  final UpdateTaskStatusDto updateTaskStatusDto;

  const TaskUpdateRequested({required this.updateTaskStatusDto});

  @override
  List<Object> get props => [updateTaskStatusDto];
}

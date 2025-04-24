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
  final int childrenId;

  const TaskGetRequested({required this.childrenId});

  @override
  List<Object> get props => [childrenId];
}

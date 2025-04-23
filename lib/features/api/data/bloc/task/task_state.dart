part of 'task_bloc.dart';

abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object?> get props => [];
}

class TaskLoading extends TaskState {}

class TaskInitial extends TaskState {}

class TaskError extends TaskState {
  final String message;

  const TaskError({required this.message});

  @override
  List<Object> get props => [message];
}

class TaskSuccess extends TaskState {
  final String message;
  final int taskId;

  const TaskSuccess({required this.message, required this.taskId});

  @override
  List<Object?> get props => [message, taskId];
}

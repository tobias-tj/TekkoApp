import 'package:bloc/bloc.dart';
import 'package:tekko/features/api/data/models/create_task_model.dart';
import 'package:tekko/features/api/data/models/get_task_dto.dart';
import 'package:tekko/features/api/domain/usecases/create_task.dart';
import 'package:equatable/equatable.dart';
import 'package:tekko/features/api/domain/usecases/get_task_by_kid.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final CreateTaskUseCases createTask;
  final GetTaskByKidUseCases getTasksByKid;

  TaskBloc({required this.createTask, required this.getTasksByKid})
      : super(TaskInitial()) {
    on<TaskRequested>(_onTaskRequested);
    on<TaskGetRequested>(_onTaskGetRequested);
  }

  Future<void> _onTaskRequested(
    TaskRequested event,
    Emitter<TaskState> emit,
  ) async {
    emit(TaskLoading());

    try {
      final result = await createTask(event.taskModel);

      if (result.containsKey('taskId')) {
        emit(TaskSuccess(
            message: result['message'], taskId: result['taskId'] as int));
      } else {
        emit(TaskError(
            message: result['message']?.toString() ?? 'Failed to create task'));
      }
    } catch (e) {
      emit(TaskError(
          message: e.toString().contains('Exception:')
              ? e.toString().split('Exception:')[1].trim()
              : 'An unexpected error occurred'));
    }
  }

  Future<void> _onTaskGetRequested(
      TaskGetRequested event, Emitter<TaskState> emit) async {
    emit(TaskLoading());

    try {
      final result = await getTasksByKid(event.childrenId);
      emit(TaskGetSuccess(tasks: result));
    } catch (e) {
      emit(TaskError(
          message: e.toString().contains('Exception:')
              ? e.toString().split('Exception:')[1].trim()
              : 'Failed to load activities'));
    }
  }
}

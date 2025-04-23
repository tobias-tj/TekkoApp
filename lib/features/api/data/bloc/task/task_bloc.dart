import 'package:bloc/bloc.dart';
import 'package:tekko/features/api/data/models/create_task_model.dart';
import 'package:tekko/features/api/domain/usecases/create_task.dart';
import 'package:equatable/equatable.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final CreateTaskUseCases createTask;

  TaskBloc({required this.createTask}) : super(TaskInitial()) {
    on<TaskRequested>(_onTaskRequested);
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
}

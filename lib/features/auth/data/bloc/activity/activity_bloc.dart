import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tekko/features/auth/data/models/form_activity_model.dart';
import 'package:tekko/features/auth/domain/usecases/create_activity.dart';

part 'activity_event.dart';
part 'activity_state.dart';

class ActivityBloc extends Bloc<ActivityEvent, ActivityState> {
  final CreateActivityUseCases createActivity;

  ActivityBloc({required this.createActivity}) : super(ActivityInitial()) {
    on<ActivityRequested>(_onActivityRequested);
  }

  Future<void> _onActivityRequested(
    ActivityRequested event,
    Emitter<ActivityState> emit,
  ) async {
    emit(ActivityLoading());

    try {
      final result = await createActivity(event.activityModel);

      if (result.containsKey('activityId') &&
          result.containsKey('activityDetailId')) {
        emit(ActivitySuccess(
          message: result['message'] as String,
          activityId: result['activityId'] as int,
          activityDetailId: result['activityDetailId'] as int,
        ));
      } else {
        emit(ActivityError(
          message: result['message']?.toString() ?? 'Failed to create activity',
        ));
      }
    } catch (e) {
      emit(ActivityError(
        message: e.toString().contains('Exception:')
            ? e.toString().split('Exception:')[1].trim()
            : 'An unexpected error occurred',
      ));
    }
  }
}

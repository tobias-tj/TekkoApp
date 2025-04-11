import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tekko/features/auth/data/models/activity_kid_dto.dart';
import 'package:tekko/features/auth/data/models/filter_activity_dto.dart';
import 'package:tekko/features/auth/data/models/form_activity_model.dart';
import 'package:tekko/features/auth/domain/usecases/create_activity.dart';
import 'package:tekko/features/auth/domain/usecases/get_activities.dart';
import 'package:tekko/features/auth/domain/usecases/get_activities_by_kid.dart';

part 'activity_event.dart';
part 'activity_state.dart';

class ActivityBloc extends Bloc<ActivityEvent, ActivityState> {
  final CreateActivityUseCases createActivity;
  final GetActivitiesUseCases getActivities;
  final GetActivitiesByKidUseCases getActivitiesByKid;

  ActivityBloc(
      {required this.createActivity,
      required this.getActivities,
      required this.getActivitiesByKid})
      : super(ActivityInitial()) {
    on<ActivityRequested>(_onActivityRequested);
    on<ActivitiesLoadRequested>(_onActivitiesLoadRequested);
    on<ActivityLoadKidRequested>(_onActivitiesKidLoadRequested);
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

  Future<void> _onActivitiesLoadRequested(
    ActivitiesLoadRequested event,
    Emitter<ActivityState> emit,
  ) async {
    emit(ActivityLoading());

    try {
      final activities = await getActivities(
          event.dateFilter, event.parentId, event.statusFilter);
      emit(ActivitiesLoadSuccess(activities: activities));
    } catch (e) {
      emit(ActivityError(
        message: e.toString().contains('Exception:')
            ? e.toString().split('Exception:')[1].trim()
            : 'Failed to load activities',
      ));
    }
  }

  Future<void> _onActivitiesKidLoadRequested(
    ActivityLoadKidRequested event,
    Emitter<ActivityState> emit,
  ) async {
    emit(ActivityLoading());

    try {
      final activities =
          await getActivitiesByKid(event.dateFilter, event.kidId);
      emit(ActivitiesKidLoadSuccess(activities: activities));
    } catch (e) {
      emit(ActivityError(
          message: e.toString().contains('Exception:')
              ? e.toString().split('Exception:')[1].trim()
              : 'Failed to load activities'));
    }
  }
}

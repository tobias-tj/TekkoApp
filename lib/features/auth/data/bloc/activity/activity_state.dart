part of 'activity_bloc.dart';

abstract class ActivityState extends Equatable {
  const ActivityState();

  @override
  List<Object> get props => [];
}

class ActivityLoading extends ActivityState {}

class ActivityInitial extends ActivityState {}

class ActivitySuccess extends ActivityState {
  final String message;
  final int activityId;
  final int activityDetailId;

  const ActivitySuccess(
      {required this.message,
      required this.activityId,
      required this.activityDetailId});

  @override
  List<Object> get props => [message, activityId, activityDetailId];
}

class ActivityError extends ActivityState {
  final String message;

  const ActivityError({required this.message});

  @override
  List<Object> get props => [message];
}

class ActivitiesLoadSuccess extends ActivityState {
  final List<FilterActivityDto> activities;

  const ActivitiesLoadSuccess({required this.activities});

  @override
  List<Object> get props => [activities];
}

class ActivitiesKidLoadSuccess extends ActivityState {
  final List<ActivityKidDto> activities;

  const ActivitiesKidLoadSuccess({required this.activities});

  @override
  List<Object> get props => [activities];
}

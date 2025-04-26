part of 'activity_bloc.dart';

abstract class ActivityEvent extends Equatable {
  const ActivityEvent();

  @override
  List<Object> get props => [];
}

class ActivityRequested extends ActivityEvent {
  final FormActivityModel activityModel;

  const ActivityRequested({required this.activityModel});

  @override
  List<Object> get props => [activityModel];
}

class ActivitiesLoadRequested extends ActivityEvent {
  final String dateFilter;
  final String token;
  final String? statusFilter;

  const ActivitiesLoadRequested(
      {required this.dateFilter, required this.token, this.statusFilter});

  @override
  List<Object> get props => [dateFilter, token];
}

class ActivityLoadKidRequested extends ActivityEvent {
  final String dateFilter;
  final String token;

  const ActivityLoadKidRequested(
      {required this.dateFilter, required this.token});

  @override
  List<Object> get props => [dateFilter, token];
}

class ActivityUpdateLoadRequested extends ActivityEvent {
  final int activityId;
  final String token;

  const ActivityUpdateLoadRequested(
      {required this.activityId, required this.token});

  @override
  List<Object> get props => ([activityId]);
}

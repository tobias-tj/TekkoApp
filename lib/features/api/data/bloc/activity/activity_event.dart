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
  final int parentId;
  final String? statusFilter;

  const ActivitiesLoadRequested(
      {required this.dateFilter, required this.parentId, this.statusFilter});

  @override
  List<Object> get props => [dateFilter, parentId];
}

class ActivityLoadKidRequested extends ActivityEvent {
  final String dateFilter;
  final int kidId;

  const ActivityLoadKidRequested(
      {required this.dateFilter, required this.kidId});

  @override
  List<Object> get props => [dateFilter, kidId];
}

class ActivityUpdateLoadRequested extends ActivityEvent {
  final int activityId;

  const ActivityUpdateLoadRequested({required this.activityId});

  @override
  List<Object> get props => ([activityId]);
}

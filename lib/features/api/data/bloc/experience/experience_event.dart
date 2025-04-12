part of 'experience_bloc.dart';

abstract class ExperienceEvent extends Equatable {
  const ExperienceEvent();

  @override
  List<Object> get props => [];
}

class FetchExperienceEvent extends ExperienceEvent {
  final int childrenId;

  const FetchExperienceEvent(this.childrenId);

  @override
  List<Object> get props => [childrenId];
}

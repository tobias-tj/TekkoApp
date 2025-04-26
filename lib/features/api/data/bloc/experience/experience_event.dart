part of 'experience_bloc.dart';

abstract class ExperienceEvent extends Equatable {
  const ExperienceEvent();

  @override
  List<Object> get props => [];
}

class FetchExperienceEvent extends ExperienceEvent {
  final String token;

  const FetchExperienceEvent(this.token);

  @override
  List<Object> get props => [token];
}

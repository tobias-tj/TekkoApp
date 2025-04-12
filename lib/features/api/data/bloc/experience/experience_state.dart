part of 'experience_bloc.dart';

abstract class ExperienceState extends Equatable {
  const ExperienceState();

  @override
  List<Object> get props => [];
}

class ExperienceInitial extends ExperienceState {}

class ExperienceLoading extends ExperienceState {}

class ExperienceLoaded extends ExperienceState {
  final ExperienceDto experience;

  const ExperienceLoaded(this.experience);

  @override
  List<Object> get props => [experience];
}

class ExperienceError extends ExperienceState {
  final String message;

  const ExperienceError(this.message);

  @override
  List<Object> get props => [message];
}

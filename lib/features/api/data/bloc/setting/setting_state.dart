part of 'setting_bloc.dart';

abstract class SettingState extends Equatable {
  const SettingState();

  @override
  List<Object> get props => [];
}

class SettingLoading extends SettingState {}

class SettingInitial extends SettingState {}

class SettingError extends SettingState {
  final String message;

  const SettingError({required this.message});

  @override
  List<Object> get props => [message];
}

class SettingProfileSuccess extends SettingState {
  final DetailsProfileDto detailsProfileDto;

  const SettingProfileSuccess({required this.detailsProfileDto});

  @override
  List<Object> get props => [detailsProfileDto];
}

class SettingUpdateProfileSuccess extends SettingState {
  final String message;

  const SettingUpdateProfileSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class SettingUpdatePinTokenSuccess extends SettingState {
  final String message;

  const SettingUpdatePinTokenSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

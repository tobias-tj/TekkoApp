part of 'setting_bloc.dart';

abstract class SettingEvent extends Equatable {
  const SettingEvent();

  @override
  List<Object> get props => [];
}

class SettingProfileRequested extends SettingEvent {
  final String token;

  const SettingProfileRequested({required this.token});

  @override
  List<Object> get props => [token];
}

class SettingUpdateProfileRequested extends SettingEvent {
  final UpdateProfileDto updateProfileDto;

  const SettingUpdateProfileRequested({required this.updateProfileDto});

  @override
  List<Object> get props => [updateProfileDto];
}

class SettingUpdatePinTokenRequested extends SettingEvent {
  final String token;
  final String pinToken;
  final String oldToken;

  const SettingUpdatePinTokenRequested(
      {required this.token, required this.pinToken, required this.oldToken});

  @override
  List<Object> get props => [token, pinToken, oldToken];
}

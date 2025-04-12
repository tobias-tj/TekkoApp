part of 'setting_bloc.dart';

abstract class SettingEvent extends Equatable {
  const SettingEvent();

  @override
  List<Object> get props => [];
}

class SettingProfileRequested extends SettingEvent {
  final int parentId;
  final int childrenId;

  const SettingProfileRequested(
      {required this.parentId, required this.childrenId});

  @override
  List<Object> get props => [parentId, childrenId];
}

class SettingUpdateProfileRequested extends SettingEvent {
  final UpdateProfileDto updateProfileDto;

  const SettingUpdateProfileRequested({required this.updateProfileDto});

  @override
  List<Object> get props => [updateProfileDto];
}

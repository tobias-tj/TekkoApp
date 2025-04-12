import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tekko/features/api/data/models/details_profile_dto.dart';
import 'package:tekko/features/api/data/models/update_profile_dto.dart';
import 'package:tekko/features/api/domain/usecases/get_profile_details.dart';
import 'package:tekko/features/api/domain/usecases/update_profile.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  final GetProfileDetailsUseCases getProfileDetails;
  final UpdateProfileUseCases updateProfileDetails;

  SettingBloc(
      {required this.getProfileDetails, required this.updateProfileDetails})
      : super(SettingInitial()) {
    on<SettingProfileRequested>(_onSettingProfileRequested);
    on<SettingUpdateProfileRequested>(_onSettingUpdateProfileRequested);
  }

  Future<void> _onSettingProfileRequested(
    SettingProfileRequested event,
    Emitter<SettingState> emit,
  ) async {
    emit(SettingLoading());

    try {
      final profile = await getProfileDetails(
        event.parentId,
        event.childrenId,
      );

      emit(SettingProfileSuccess(detailsProfileDto: profile));
    } catch (e) {
      emit(SettingError(
        message: e.toString().contains('Exception:')
            ? e.toString().split('Exception:')[1].trim()
            : 'An unexpected error occurred',
      ));
    }
  }

  Future<void> _onSettingUpdateProfileRequested(
    SettingUpdateProfileRequested event,
    Emitter<SettingState> emit,
  ) async {
    emit(SettingLoading());

    try {
      await updateProfileDetails(event.updateProfileDto);

      emit(SettingUpdateProfileSuccess(
          message: 'Perfil Actualizado Correctamente'));
    } catch (e) {
      emit(SettingError(
        message: e.toString().contains('Exception:')
            ? e.toString().split('Exception:')[1].trim()
            : 'An unexpected error occurred',
      ));
    }
  }
}

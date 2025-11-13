import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tekko/features/api/data/models/experience_dto.dart';
import 'package:tekko/features/api/domain/usecases/get_experience.dart';
import 'package:tekko/features/api/domain/usecases/update_experience.dart';

part 'experience_event.dart';
part 'experience_state.dart';

class ExperienceBloc extends Bloc<ExperienceEvent, ExperienceState> {
  final GetExperience getExperience;
  final UpdateExperience updateExperience;

  ExperienceBloc({required this.getExperience, required this.updateExperience})
      : super(ExperienceInitial()) {
    on<FetchExperienceEvent>(_onFetchExperience);
    on<UpdateExperienceEvent>(_onUpdateExperience);
  }

  FutureOr<void> _onFetchExperience(
    FetchExperienceEvent event,
    Emitter<ExperienceState> emit,
  ) async {
    emit(ExperienceLoading());

    try {
      final experience = await getExperience.execute(event.token);
      emit(ExperienceLoaded(experience));
    } catch (e) {
      emit(ExperienceError(e.toString()));
    }
  }

  FutureOr<void> _onUpdateExperience(
    UpdateExperienceEvent event,
    Emitter<ExperienceState> emit,
  ) async {
    emit(ExperienceLoading());

    try {
      await updateExperience.execute(event.token, event.newExp);
      emit(const ExperienceUpdated('Experiencia actualizada con éxito.'));
    } catch (e) {
      emit(ExperienceError(e.toString()));
    }
  }
}

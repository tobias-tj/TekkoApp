import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tekko/features/api/data/models/experience_dto.dart';
import 'package:tekko/features/api/domain/usecases/get_experience.dart';

part 'experience_event.dart';
part 'experience_state.dart';

class ExperienceBloc extends Bloc<ExperienceEvent, ExperienceState> {
  final GetExperience getExperience;

  ExperienceBloc({required this.getExperience}) : super(ExperienceInitial()) {
    on<FetchExperienceEvent>(_onFetchExperience);
  }

  FutureOr<void> _onFetchExperience(
    FetchExperienceEvent event,
    Emitter<ExperienceState> emit,
  ) async {
    emit(ExperienceLoading());

    try {
      final experience = await getExperience.execute(event.childrenId);
      emit(ExperienceLoaded(experience));
    } catch (e) {
      emit(ExperienceError(e.toString()));
    }
  }
}

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tekko/features/api/data/models/create_list_map_dto.dart';
import 'package:tekko/features/api/domain/usecases/create_map_info.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final CreateMapInfoUseCases createMapInfo;

  MapBloc({required this.createMapInfo}) : super(MapInitial()) {
    on<MapCreatedRequested>(_onCreateMapRequested);
  }

  Future<void> _onCreateMapRequested(
      MapCreatedRequested event, Emitter<MapState> emit) async {
    emit(MapLoading());

    try {
      await createMapInfo(event.createMapDto);
      emit(MapCreateInfoSuccess(message: 'Ubicacion guardada con exito'));
    } catch (e) {
      emit(MapError(
          message: e.toString().contains('Exception:')
              ? e.toString().split('Exception:')[1].trim()
              : 'Error al actualizar la actividad'));
    }
  }
}

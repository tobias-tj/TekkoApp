import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tekko/features/api/data/models/create_list_map_dto.dart';
import 'package:tekko/features/api/data/models/get_maps_dto.dart';
import 'package:tekko/features/api/domain/usecases/create_map_info.dart';
import 'package:tekko/features/api/domain/usecases/get_map_info.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final CreateMapInfoUseCases createMapInfo;
  final GetMapInfoUseCases getMapInfo;

  MapBloc({required this.createMapInfo, required this.getMapInfo})
      : super(MapInitial()) {
    on<MapCreatedRequested>(_onCreateMapRequested);
    on<MapGetRequested>(_onGetMapRequested);
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

  Future<void> _onGetMapRequested(
      MapGetRequested event, Emitter<MapState> emit) async {
    emit(MapLoading());

    try {
      final mapInfo = await getMapInfo(event.token);
      emit(MapGetInfoSuccess(getMapInfo: mapInfo));
    } catch (e) {
      emit(MapError(
          message: e.toString().contains('Exception:')
              ? e.toString().split('Exception:')[1].trim()
              : 'Error al actualizar la actividad'));
    }
  }
}

part of 'map_bloc.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class MapCreatedRequested extends MapEvent {
  final CreateListMapDto createMapDto;

  const MapCreatedRequested({required this.createMapDto});

  @override
  List<Object> get props => [createMapDto];
}

class MapGetRequested extends MapEvent {
  final String token;

  const MapGetRequested({required this.token});

  @override
  List<Object> get props => [token];
}

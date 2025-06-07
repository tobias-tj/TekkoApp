part of 'map_bloc.dart';

abstract class MapState extends Equatable {
  const MapState();

  @override
  List<Object> get props => [];
}

class MapLoading extends MapState {}

class MapInitial extends MapState {}

class MapError extends MapState {
  final String message;

  const MapError({required this.message});

  @override
  List<Object> get props => [message];
}

class MapCreateInfoSuccess extends MapState {
  final String message;

  const MapCreateInfoSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

part of 'recovery_bloc.dart';

abstract class RecoveryState extends Equatable {
  const RecoveryState();

  @override
  List<Object> get props => [];
}

class RecoveryInitial extends RecoveryState {}

class RecoveryLoading extends RecoveryState {}

class RecoverySuccess extends RecoveryState {
  final String message;

  const RecoverySuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class RecoveryError extends RecoveryState {
  final String error;

  const RecoveryError({required this.error});

  @override
  List<Object> get props => [error];
}

part of 'recovery_bloc.dart';

abstract class RecoveryEvent extends Equatable {
  const RecoveryEvent();

  @override
  List<Object> get props => [];
}

class RecoveryRequested extends RecoveryEvent {
  final String email;

  const RecoveryRequested({required this.email});

  @override
  List<Object> get props => [email];
}

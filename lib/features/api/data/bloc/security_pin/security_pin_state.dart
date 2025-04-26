part of 'security_pin_bloc.dart';

abstract class SecurityPinState extends Equatable {
  const SecurityPinState();

  @override
  List<Object> get props => [];
}

class SecurityPinInitial extends SecurityPinState {}

class SecurityPinLoading extends SecurityPinState {}

class SecurityPinSuccess extends SecurityPinState {
  final String fullName;

  const SecurityPinSuccess({required this.fullName});

  @override
  List<Object> get props => [fullName];
}

class SecurityPinError extends SecurityPinState {
  final String message;

  const SecurityPinError({required this.message});

  @override
  List<Object> get props => [message];
}

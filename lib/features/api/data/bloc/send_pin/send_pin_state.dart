part of 'send_pin_bloc.dart';

abstract class SendPinState extends Equatable {
  const SendPinState();

  @override
  List<Object> get props => [];
}

class SendPinLoading extends SendPinState {}

class SendPinInitial extends SendPinState {}

class SendPinSuccess extends SendPinState {
  final String message;

  const SendPinSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class SendPinError extends SendPinState {
  final String error;

  const SendPinError({required this.error});

  @override
  List<Object> get props => [error];
}

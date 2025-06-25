part of 'send_pin_bloc.dart';

abstract class SendPinEvent extends Equatable {
  const SendPinEvent();

  @override
  List<Object> get props => [];
}

class SendPinRequested extends SendPinEvent {
  final String token;

  const SendPinRequested({required this.token});

  @override
  List<Object> get props => [token];
}

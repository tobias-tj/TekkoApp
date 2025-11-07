part of 'security_pin_bloc.dart';

abstract class SecurityPinEvent extends Equatable {
  const SecurityPinEvent();

  @override
  List<Object> get props => [];
}

class SecurityPinRequested extends SecurityPinEvent {
  final SecurityModel securityModel;

  const SecurityPinRequested({required this.securityModel});

  @override
  List<Object> get props => [securityModel];
}

class SendSecurityPinRequested extends SecurityPinEvent {
  final String token;
  final String email;

  const SendSecurityPinRequested({required this.token, required this.email});

  @override
  List<Object> get props => [token, email];
}

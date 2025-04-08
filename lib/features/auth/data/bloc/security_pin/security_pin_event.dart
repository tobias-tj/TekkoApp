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

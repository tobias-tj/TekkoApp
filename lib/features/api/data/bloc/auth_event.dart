part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class RegisterRequested extends AuthEvent {
  final AuthModel authModel;

  const RegisterRequested({required this.authModel});

  @override
  List<Object> get props => [authModel];
}

class LoginRequested extends AuthEvent {
  final LoginModel loginModel;

  const LoginRequested({required this.loginModel});

  @override
  List<Object> get props => [loginModel];
}

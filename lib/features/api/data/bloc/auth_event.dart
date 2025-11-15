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

class RegisterWithGoogleRequested extends AuthEvent {
  final String idToken;

  const RegisterWithGoogleRequested({required this.idToken});

  @override
  List<Object> get props => [idToken];
}

class LoginWithGoogleRequested extends AuthEvent {
  final String idToken;

  const LoginWithGoogleRequested({required this.idToken});

  @override
  List<Object> get props => [idToken];
}

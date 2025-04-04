part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final int? parentId;
  final int? childrenId;

  const AuthSuccess({this.parentId, this.childrenId});

  @override
  List<Object> get props => [parentId ?? 0, childrenId ?? 0];
}

class AuthFailure extends AuthState {
  final String error;

  const AuthFailure({required this.error});

  @override
  List<Object> get props => [error];
}

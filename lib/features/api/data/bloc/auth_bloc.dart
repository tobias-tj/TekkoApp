import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tekko/features/api/data/models/auth_model.dart';
import 'package:tekko/features/api/data/models/login_model.dart';
import 'package:tekko/features/api/domain/usecases/login_usecase.dart';
import 'package:tekko/features/api/domain/usecases/register_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final RegisterUseCase registerUseCase;
  final LoginUsecase loginUsecase;

  AuthBloc({required this.registerUseCase, required this.loginUsecase})
      : super(AuthInitial()) {
    on<RegisterRequested>(_onRegisterRequested);
    on<LoginRequested>(_onLoginRequested);
  }

  Future<void> _onRegisterRequested(
    RegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final response = await registerUseCase(event.authModel);
      emit(AuthSuccess(
        token: response['token'],
      ));
    } catch (e) {
      emit(AuthFailure(error: e.toString()));
    }
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final response = await loginUsecase(event.loginModel);
      emit(AuthSuccess(
        token: response['token'],
      ));
    } catch (e) {
      emit(AuthFailure(error: e.toString()));
    }
  }
}

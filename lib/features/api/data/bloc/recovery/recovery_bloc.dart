import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tekko/features/api/domain/usecases/recovery_account.dart';

part 'recovery_event.dart';
part 'recovery_state.dart';

class RecoveryBloc extends Bloc<RecoveryEvent, RecoveryState> {
  final RecoveryAccount recoveryAccount;
  RecoveryBloc({required this.recoveryAccount}) : super(RecoveryInitial()) {
    on<RecoveryRequested>(_onRecoveryRequested);
  }

  Future<void> _onRecoveryRequested(
      RecoveryRequested event, Emitter<RecoveryState> emit) async {
    emit(RecoveryLoading());

    try {
      await recoveryAccount(event.email);
      emit(RecoverySuccess(
          message: 'Se ha enviado al email registrado su nueva contraseña'));
    } catch (e) {
      emit(RecoveryError(
          error: e.toString().contains('Exception:')
              ? e.toString().split('Exception:')[1].trim()
              : 'An unexpected error occurred'));
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tekko/features/api/domain/usecases/send_pin_by_email.dart';

part 'send_pin_event.dart';
part 'send_pin_state.dart';

class SendPinBloc extends Bloc<SendPinEvent, SendPinState> {
  final SendPinByEmail sendPinByEmail;

  SendPinBloc({required this.sendPinByEmail}) : super(SendPinInitial()) {
    on<SendPinRequested>(_onSendPinRequested);
  }

  Future<void> _onSendPinRequested(
    SendPinRequested event,
    Emitter<SendPinState> emit,
  ) async {
    emit(SendPinLoading());

    try {
      await sendPinByEmail(event.token);
      emit(SendPinSuccess(
          message: 'Se ha enviado el PIN al correo electrónico'));
    } catch (e) {
      emit(SendPinError(
        error: e.toString().contains('Exception:')
            ? e.toString().split('Exception:')[1].trim()
            : 'An unexpected error occurred',
      ));
    }
  }
}

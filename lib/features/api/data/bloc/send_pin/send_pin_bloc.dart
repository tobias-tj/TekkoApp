import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:tekko/features/api/domain/usecases/send_pin_by_email.dart';

part 'send_pin_event.dart';
part 'send_pin_state.dart';

class SendPinBloc extends Bloc<SendPinEvent, SendPinState> {
  final SendPinByEmail sendPinByEmail;
  final FirebaseAnalytics analytics;

  SendPinBloc({required this.sendPinByEmail, required this.analytics})
      : super(SendPinInitial()) {
    on<SendPinRequested>(_onSendPinRequested);
  }

  Future<void> _onSendPinRequested(
    SendPinRequested event,
    Emitter<SendPinState> emit,
  ) async {
    emit(SendPinLoading());

    try {
      await sendPinByEmail(event.token);

      /// 🔹 Track en Firebase
      await analytics.logEvent(
        name: 'send_pin_requested',
        parameters: {
          'token_length': event.token.length,
          'timestamp': DateTime.now().toIso8601String(),
        },
      );
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

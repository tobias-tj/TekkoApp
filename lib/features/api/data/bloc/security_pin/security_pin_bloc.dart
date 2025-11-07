import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:tekko/features/api/data/models/security_model.dart';
import 'package:tekko/features/api/domain/usecases/send_pin_by_email.dart';
import 'package:tekko/features/api/domain/usecases/verify_security_pin.dart';
import 'package:tekko/features/services/firebase_message.dart';

part 'security_pin_event.dart';
part 'security_pin_state.dart';

class SecurityPinBloc extends Bloc<SecurityPinEvent, SecurityPinState> {
  final VerifySecurityPinUseCase verifySecurityPin;
  final SendPinByEmail sendPinByEmail;
  StreamSubscription? _pinSubscription;
  final FirebaseAnalytics analytics;

  SecurityPinBloc(
      {required this.verifySecurityPin,
      required this.sendPinByEmail,
      required this.analytics})
      : super(SecurityPinInitial()) {
    on<SecurityPinRequested>(_onVerifySecurityPin);
    on<SendSecurityPinRequested>(_onSenPinSecurity);
  }

  Future<void> _onVerifySecurityPin(
    SecurityPinRequested event,
    Emitter<SecurityPinState> emit,
  ) async {
    emit(SecurityPinLoading());

    try {
      await _pinSubscription?.cancel();

      final result = await verifySecurityPin.call(event.securityModel);

      if (result['success'] == true) {
        emit(SecurityPinSuccess(
          fullName: result['fullName'] as String,
        ));
      } else {
        emit(SecurityPinError(
          message: result['message']?.toString() ?? 'PIN verification failed',
        ));
      }
    } catch (e) {
      emit(SecurityPinError(
        message: e.toString().contains('Exception:')
            ? e.toString().split('Exception:')[1].trim()
            : 'An unexpected error occurred',
      ));
    }
  }

  Future<void> _onSenPinSecurity(
    SendSecurityPinRequested event,
    Emitter<SecurityPinState> emit,
  ) async {
    emit(SecurityPinLoading());

    try {
      await sendPinByEmail(event.token);
      await analytics.logEvent(
        name: 'resend_security_pin_requested',
        parameters: {
          'token_length': event.token.length,
          'email': event.email,
          'timestamp': DateTime.now().toIso8601String(),
        },
      );

      await FirebaseMessageService.showLocalNotification(
        title: '¡Tu PIN fue restablecido! 🔑',
        body: 'Enviamos tu nuevo PIN a ${event.email}.',
      );
      emit(SendPinSecuritySuccess(
        message: "Se ha restablecido el PIN y enviado al correo electrónico",
      ));
    } catch (e) {
      emit(SendPinSecurityError(
        message: e.toString().contains('Exception:')
            ? e.toString().split('Exception:')[1].trim()
            : 'An unexpected error occurred',
      ));
    }
  }

  @override
  Future<void> close() {
    _pinSubscription?.cancel();
    return super.close();
  }
}

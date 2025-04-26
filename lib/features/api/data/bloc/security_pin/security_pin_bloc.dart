import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tekko/features/api/data/models/security_model.dart';
import 'package:tekko/features/api/domain/usecases/verify_security_pin.dart';

part 'security_pin_event.dart';
part 'security_pin_state.dart';

class SecurityPinBloc extends Bloc<SecurityPinEvent, SecurityPinState> {
  final VerifySecurityPinUseCase verifySecurityPin;
  StreamSubscription? _pinSubscription;

  SecurityPinBloc({required this.verifySecurityPin})
      : super(SecurityPinInitial()) {
    on<SecurityPinRequested>(_onVerifySecurityPin);
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

  @override
  Future<void> close() {
    _pinSubscription?.cancel();
    return super.close();
  }
}

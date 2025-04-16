import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tekko/features/api/domain/usecases/create_payment.dart';
import 'donation_event.dart';
import 'donation_state.dart';

class DonationBloc extends Bloc<DonationEvent, DonationState> {
  final CreatePaymentIntentUseCase createPaymentIntent;

  DonationBloc({required this.createPaymentIntent}) : super(DonationInitial()) {
    on<StartDonationEvent>((event, emit) async {
      emit(DonationLoading());
      try {
        final clientSecret = await createPaymentIntent(event.donation);
        emit(DonationClientSecretReady(clientSecret));
      } catch (e) {
        emit(DonationError("Error: ${e.toString()}"));
      }
    });
  }
}

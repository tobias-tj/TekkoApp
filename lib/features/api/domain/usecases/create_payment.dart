import 'package:tekko/features/api/data/models/donation.dart';

import '../repositories/donation_repository.dart';

class CreatePaymentIntentUseCase {
  final DonationRepository repository;

  CreatePaymentIntentUseCase(this.repository);

  Future<String> call(Donation donation) {
    return repository.createPaymentIntent(donation);
  }
}

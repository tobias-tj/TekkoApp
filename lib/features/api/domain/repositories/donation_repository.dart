import 'package:tekko/features/api/data/models/donation.dart';

abstract class DonationRepository {
  Future<String> createPaymentIntent(Donation donation);
}

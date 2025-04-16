import 'package:tekko/features/api/data/models/donation.dart';

abstract class DonationEvent {}

class StartDonationEvent extends DonationEvent {
  final Donation donation;
  StartDonationEvent(this.donation);
}

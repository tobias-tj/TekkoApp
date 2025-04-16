abstract class DonationState {}

class DonationInitial extends DonationState {}

class DonationLoading extends DonationState {}

class DonationClientSecretReady extends DonationState {
  final String clientSecret;
  DonationClientSecretReady(this.clientSecret);
}

class DonationError extends DonationState {
  final String message;
  DonationError(this.message);
}

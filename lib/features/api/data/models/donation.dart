class Donation {
  final String token;
  final int amount;
  final String currency;
  final String fullName;
  final String email;

  Donation(
      {required this.token,
      required this.amount,
      this.currency = 'usd',
      required this.fullName,
      required this.email});
}

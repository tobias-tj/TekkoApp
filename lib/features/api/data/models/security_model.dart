class SecurityModel {
  final String pin;
  final String token;

  SecurityModel({required this.pin, required this.token});

  Map<String, dynamic> toJson() => {'pinSecurity': pin};
}

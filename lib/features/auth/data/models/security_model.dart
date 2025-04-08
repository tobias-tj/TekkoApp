class SecurityModel {
  final String pin;
  final int parentId;

  SecurityModel({required this.pin, required this.parentId});

  Map<String, dynamic> toJson() => {'pinSecurity': pin, 'parentId': parentId};
}

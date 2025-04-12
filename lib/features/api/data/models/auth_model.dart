class AuthModel {
  final String fullNameParent;
  final String email;
  final String password;
  final String nameKid;
  final int ageKid;

  AuthModel({
    required this.fullNameParent,
    required this.email,
    required this.password,
    required this.nameKid,
    required this.ageKid,
  });

  Map<String, dynamic> toJson() => {
        'fullNameParent': fullNameParent,
        'email': email,
        'password': password,
        'nameKid': nameKid,
        'ageKid': ageKid,
      };
}

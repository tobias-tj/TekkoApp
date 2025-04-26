class UpdateProfileDto {
  final String token;
  final String nameParent;
  final String nameChildren;
  final int age;

  UpdateProfileDto({
    required this.token,
    required this.nameParent,
    required this.nameChildren,
    required this.age,
  });

  Map<String, dynamic> toJson() => {
        'nameParent': nameParent,
        'nameChildren': nameChildren,
        'age': age,
      };
}

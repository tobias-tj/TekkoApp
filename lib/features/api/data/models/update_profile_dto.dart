class UpdateProfileDto {
  final int parentId;
  final int childrenId;
  final String nameParent;
  final String nameChildren;
  final int age;

  UpdateProfileDto({
    required this.parentId,
    required this.childrenId,
    required this.nameParent,
    required this.nameChildren,
    required this.age,
  });

  Map<String, dynamic> toJson() => {
        'parentId': parentId,
        'childrenId': childrenId,
        'nameParent': nameParent,
        'nameChildren': nameChildren,
        'age': age,
      };
}

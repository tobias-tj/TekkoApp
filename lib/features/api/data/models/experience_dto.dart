class ExperienceDto {
  final String fullName;
  final int exp;
  final int level;
  final int expNextlevel;
  final int nextLevel;

  ExperienceDto({
    required this.fullName,
    required this.exp,
    required this.level,
    required this.expNextlevel,
    required this.nextLevel,
  });

  Map<String, dynamic> toJson() => {
        'fullName': fullName,
        'exp': exp,
        'level': level,
        'expNextLevel': expNextlevel,
        'nextLevel': nextLevel
      };
}

class User {
  User({
    required this.id,

    required this.name,
    required this.gender,
    required this.isMarried,
    required this.numOfChildren
  });

  final String id;

  final String name;
  final Gender gender;
  final bool? isMarried;
  final int? numOfChildren;


  static const String UNKNOWN_ID = "UNKNOWN_ID";
  static const String UNKNOWN_NAME = "UNKNOWN_ID";

  static User unknownUser() {
    return User(id: UNKNOWN_ID, name: UNKNOWN_NAME, gender: Gender.unknown, isMarried: null, numOfChildren: null);
  }

  User copyWith({
    String? id, String? name, Gender? gender, bool? isMarried, int? numOfChildren
  }) => User(
      id: id ?? this.id,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      isMarried: isMarried ?? this.isMarried,
      numOfChildren: numOfChildren ?? this.numOfChildren
  );
}

enum Gender {
  male,
  female,
  nonbinary,
  unknown,
}
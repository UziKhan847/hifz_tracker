class Student {
  Student({
    required this.fullName,
    required this.id,
    required this.parentId,
    required this.hafiz,
    required this.origin,
    required this.age,
  });

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        fullName: json['full_name'],
        id: json['id'],
        parentId: json['parent_id'],
        hafiz: json['hafiz'],
        origin: json['origin'],
        age: json['age'],
      );

  final String fullName;
  final int id;
  final String parentId;
  final bool hafiz;
  final String origin;
  final int age;
}

import 'package:json_annotation/json_annotation.dart';

part 'student.g.dart';

@JsonSerializable()
class Student {
  Student({
    required this.fullName,
    required this.id,
    required this.parentId,
    required this.hafiz,
    required this.origin,
    required this.age,
  });

  @JsonKey(name: 'full_name')
  final String fullName;

  final int id;

  @JsonKey(name: 'parent_id')
  final String parentId;

  final bool hafiz;
  final String origin;
  final int age;

  factory Student.fromJson(Map<String, dynamic> json) => _$StudentFromJson(json);

  Map<String, dynamic> toJson() => _$StudentToJson(this);

}

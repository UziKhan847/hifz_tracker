import 'package:markaz_umaza_hifz_tracker/models/student.dart';
import 'package:json_annotation/json_annotation.dart';

part 'parent.g.dart';

@JsonSerializable(explicitToJson: true)
class Parent {
  Parent({
    required this.students,
    required this.id,
    required this.fullName,
  });

  final List<Student> students;
  final String id;

  @JsonKey(name: 'full_name')
  final String? fullName;

  factory Parent.fromJson(Map<String, dynamic> json) => _$ParentFromJson(json);

  Map<String, dynamic> toJson() => _$ParentToJson(this);
}

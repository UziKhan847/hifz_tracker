import 'package:markaz_umaza_hifz_tracker/models/student/student.dart';
import 'package:json_annotation/json_annotation.dart';

part 'parent.g.dart';

@JsonSerializable(explicitToJson: true)
class Parent {
  Parent({
    required this.students,
    required this.id,
    required this.fullName,
    required this.phoneNumber,
    required this.isoCode,
    required this.dialCode,
  });

  final List<Student> students;
  final String id;

  @JsonKey(name: 'full_name')
  String? fullName;

  @JsonKey(name: 'iso_code')
  String? isoCode;

  @JsonKey(name: 'dial_code')
  String? dialCode;

  @JsonKey(name: 'phone_number')
  String? phoneNumber;

  factory Parent.fromJson(Map<String, dynamic> json) => _$ParentFromJson(json);

  Map<String, dynamic> toJson() => _$ParentToJson(this);
}

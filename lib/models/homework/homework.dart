import 'package:json_annotation/json_annotation.dart';

part 'homework.g.dart';

@JsonSerializable()
class Homework {
  Homework({
    required this.date,
    required this.sabaq,
    required this.performance,
    required this.hwNumber,
    required this.pageNumber,
    required this.juzuNumber,
    required this.studentId,
    required this.isCompleted,
    required this.id,
  });

  final String date;
  final String sabaq;
  final String? performance;

  final int id;

  @JsonKey(name: 'homework_number')
  final int hwNumber;

  @JsonKey(name: 'page_number')
  final int pageNumber;

  @JsonKey(name: 'juzu_number')
  final int juzuNumber;

  @JsonKey(name: 'student_id')
  final int studentId;

@JsonKey(name: 'is_completed')
  bool isCompleted;

  factory Homework.fromJson(Map<String, dynamic> json) =>
      _$HomeworkFromJson(json);

  Map<String, dynamic> toJson() => _$HomeworkToJson(this);
}

import 'package:markaz_umaza_hifz_tracker/models/student.dart';

class Parent {
  Parent({
    required this.students,
    required this.id,
    required this.fullName,
  });

  factory Parent.fromJson(Map<String, dynamic> json) => Parent(
        students: json['students'].map((student) => Student.fromJson(student)).toList().cast<Student>() ,
        id: json['id'],
        fullName: json['full_name'],
      );

  final List<Student> students;
  final String id;
  final String? fullName;
}

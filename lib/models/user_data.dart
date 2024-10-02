import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markaz_umaza_hifz_tracker/main.dart';
import 'package:markaz_umaza_hifz_tracker/models/student.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final userData = ChangeNotifierProvider<UserData>((ref) {
  return UserData();
});

class UserData extends ChangeNotifier {
  UserData();

  final String userId = supabase.auth.currentUser!.id;

  List<Student> studentList = [];

  Future<PostgrestList> getData() async =>
      supabase.from('profiles').select('*, students(*)').eq('id', userId);

  void addStudent(int id, String fullName, int age, String origin,
      {bool hafiz = false}) async {
    await supabase.from('students').insert({
      'id': id,
      'full_name': fullName,
      'age': age,
      'origin': origin,
      'hafiz': hafiz,
      'parent_id': userId,
    });

    studentList.add(Student(
        id: id,
        fullName: fullName,
        age: age,
        origin: origin,
        hafiz: hafiz,
        parentId: userId));

    notifyListeners();
  }
}
